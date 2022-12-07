//
//  HomeView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var arrayTaggings = [Tag]()
    @State private var arrayUnreadEntries = [Entry]()
    
    var body: some View {
        VStack {
            List(arrayUnreadEntries) { entry in
                NavigationLink {
                    EntryContentView()
                } label: {
                    EntryRowView(entry: entry)
                }
            }
        }.task {
            if arrayUnreadEntries.isEmpty {
                await getUnreadEntries()
            }
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func getUnreadEntries() async {
        if let url = URL(string: Urls.Api.unread) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        let arrayUnread = try JSONDecoder().decode([Int].self, from: data)
                        getEntries(arrayUnread: arrayUnread)
                        print("Array unread = \(arrayUnreadEntries)")
                    } catch {
                        print("HomeView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func getEntries(arrayUnread: [Int]) {
        var idsParams = "?ids="
        for unreadEntry in arrayUnread {
            idsParams += "\(unreadEntry),"
        }
        print(idsParams)
        if let url = URL(string: Urls.Api.entries + idsParams) {
            print("URL = \(url)")
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
//                        self.arrayUnreadEntries = arrayUnreadEntries
//                        getEntries(unreadEntries: arrayUnreadEntries)
                        print("Array entries = \(arrayUnreadEntries.count)")
                    } catch {
                        print("HomeView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func getTaggings() {
        if let url = URL(string: Urls.Api.taggings) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        let arrayTaggings = try JSONDecoder().decode([Tag].self, from: data)
                        print("Array tags = \(arrayTaggings)")
                        self.arrayTaggings = arrayTaggings
                    } catch {
                        print("HomeView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
