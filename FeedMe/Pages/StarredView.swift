//
//  StarredView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/9/22.
//

import SwiftUI

struct StarredView: View {
    
    @State private var arrayUnreadEntries = [Entry]()
    @State var entryIdRead = 0
    
    var body: some View {
        VStack {
            List(arrayUnreadEntries) { entry in
                NavigationLink {
                    EntryContentView(entry: entry, entryIdRead: $entryIdRead)
                } label: {
                    EntryRowView(entry: entry)
                }
            }
            .listStyle(.plain)
        }.task {
            if arrayUnreadEntries.isEmpty {
                await getStarredEntries()
            }
        }
        .navigationTitle("Starred")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func getStarredEntries() async {
        if let url = URL(string: Urls.Api.starredEntries) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        let arrayUnreadEntries = try JSONDecoder().decode([Entry].self, from: data)
                        self.arrayUnreadEntries = arrayUnreadEntries
                    } catch {
                        print("HomeView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

struct StarredView_Previews: PreviewProvider {
    static var previews: some View {
        StarredView()
    }
}
