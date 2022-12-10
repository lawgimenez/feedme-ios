//
//  TagsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/9/22.
//

import SwiftUI

struct TagsView: View {
    
    @State private var arrayTags = [Tag]()
    @State private var arrayTaggings = [Tag]()
    @State private var dictTagsList = [String: [Int]]()
    
    var body: some View {
        VStack {
            List(arrayTags) { tag in
                HStack {
                    Text(tag.name)
                    if let count = dictTagsList[tag.name]?.count {
                        Text(String(count))
                    }
                }
            }
        }
        .task {
            await getTags()
        }
        .navigationTitle("Tags")
    }
    
    private func getTags() async {
        if let url = URL(string: Urls.Api.tags) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        self.arrayTags = try JSONDecoder().decode([Tag].self, from: data)
                        getTaggings()
//                        print("Array dicts = \(dictTags)")
                    } catch {
                        print("TagsView.error = \(error)")
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
//                        if let dataString = String(bytes: data, encoding: .utf8) {
//                            print("Taggings = \(dataString)")
//                        }
                        self.arrayTaggings = try JSONDecoder().decode([Tag].self, from: data)
                        for tagging in arrayTaggings {
                            // Add feed ID to list
                            let arrayFeedIDs = dictTagsList[tagging.name]
                            if arrayFeedIDs == nil {
                                if let feedID = tagging.feedID {
                                    dictTagsList[tagging.name] = [feedID]
                                }
                            } else {
                                // If dictionary key is not empty
                                // Get List
                                var list = dictTagsList[tagging.name]
                                if let feedID = tagging.feedID {
                                    list?.append(feedID)
                                    dictTagsList[tagging.name] = list
                                }
                            }
                        } // end of for loop
                        print(dictTagsList)
//                        let arrayKeys: [String] = dictTagsList.map({ $0.key })
                    } catch {
                        print("TagsView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}
