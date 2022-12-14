//
//  HomeView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct UnreadView: View {
    
    @EnvironmentObject private var feedsObservable: FeedsObservable
    @State var entryIdRead = 0
    private var arrayTaggings = [Tag]()
    private var dictFeedSort = [String: [Int]]()
    
    var body: some View {
        VStack {
            List(feedsObservable.arrayUnreadEntries) { entry in
                NavigationLink {
                    EntryContentView(entry: entry, entryIdRead: $entryIdRead)
                } label: {
                    EntryRowView(entry: entry)
                }
            }
            .listStyle(.plain)
        }.task {
            if feedsObservable.arrayUnreadEntries.isEmpty {
                await getUnreadEntries()
            }
        }.onAppear {
            let _ = print("FeedMe.app entryIdRead = \(entryIdRead)")
            if entryIdRead != 0 {
                let indexToBeRemoved = feedsObservable.arrayUnreadEntries.firstIndex(where: {
                    $0.id == entryIdRead
                })
                if let indexToBeRemoved {
                    feedsObservable.arrayUnreadEntries.remove(at: indexToBeRemoved)
                }
            }
        }
        .onDisappear {
            entryIdRead = 0
        }
        .navigationTitle("Unread")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func getUnreadEntries() async {
        if let url = URL(string: Urls.Api.unreadEntries) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        let arrayUnreadEntries = try JSONDecoder().decode([Entry].self, from: data)
                        print("Unread = \(arrayUnreadEntries.count)")
                        DispatchQueue.main.async {
                            feedsObservable.arrayUnreadEntries = arrayUnreadEntries
                        }
                    } catch {
                        print("HomeView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func getTaggings() async {
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
                        
//                        for tagging in arrayTaggings {
//                            let currentCount = dictTags[tagging.name]
//                            dictTags[tagging.name] = currentCount! + 1
//                        }
                        print("Array taggings = \(arrayTaggings)")
                    } catch {
                        print("TagsView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

struct UnreadView_Previews: PreviewProvider {
    static var previews: some View {
        UnreadView()
    }
}
