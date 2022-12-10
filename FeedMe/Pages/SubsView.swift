//
//  SubsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct SubsView: View {
    
    @StateObject var subsOversable = SubsObservables()
//    @State private var arraySubs = [Sub]()
    
    var body: some View {
        VStack {
            List(subsOversable.arraySubs) { sub in
                Text(sub.title)
            }
        }
        .task {
            await getSubs()
        }
    }
    
    private func getSubs() async {
        if let url = URL(string: Urls.Api.subsriptions) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        if let dataString = String(bytes: data, encoding: .utf8) {
                            print("Subs = \(dataString)")
                        }
                        subsOversable.arraySubs = try JSONDecoder().decode([Sub].self, from: data)
                    } catch {
                        print("SubsView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

struct SubsView_Previews: PreviewProvider {
    static var previews: some View {
        SubsView()
    }
}
