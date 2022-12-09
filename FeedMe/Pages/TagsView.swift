//
//  TagsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/9/22.
//

import SwiftUI

struct TagsView: View {
    
    @State private var arrayTaggings = [Tag]()
    @State private var arrayTags = [Tag]()
    
    var body: some View {
        VStack {
            List(arrayTags) { tag in
                Text(tag.name)
            }
        }
        .task {
            await getTaggings()
        }
        .navigationTitle("Tags")
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
                        print("Array tags = \(arrayTaggings)")
                        for tagging in arrayTaggings {
                            if arrayTags.contains(where: {
                                $0.name == tagging.name
                            }) {
                            } else {
                                // Not found
                                arrayTags.append(tagging)
                            }
                        }
                    } catch {
                        print("HomeView.error = \(error)")
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
