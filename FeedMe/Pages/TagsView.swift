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
    @State private var dictTags: [String: Int] = [:]
    
    var body: some View {
        VStack {
            List(arrayTags) { tag in
                HStack {
                    Text(tag.name)
                    if let count = dictTags[tag.name] {
                        Text(String(count))
                    }
                }
            }
        }
        .task {
            await getTags()
            await getTaggings()
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
                        for tag in arrayTags {
                            dictTags[tag.name] = 0
                        }
                        print("Array dicts = \(dictTags)")
                    } catch {
                        print("TagsView.error = \(error)")
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
                        self.arrayTaggings = try JSONDecoder().decode([Tag].self, from: data)
                        for tagging in arrayTaggings {
                            let currentCount = dictTags[tagging.name]
                            dictTags[tagging.name] = currentCount! + 1
                        }
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

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}
