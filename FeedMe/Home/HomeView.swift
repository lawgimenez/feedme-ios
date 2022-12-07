//
//  HomeView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var arrayTaggings = [Tag]()
    @State private var arrayUnreadEntries = [Int]()
    
    var body: some View {
        VStack {
            List(arrayTaggings) { tag in
                Text(tag.name)
            }
        }.task {
            await getUnreadEntries()
        }
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
                        let arrayUnreadEntries = try JSONDecoder().decode([Int].self, from: data)
                        self.arrayUnreadEntries = arrayUnreadEntries
                        print("Array unread = \(arrayUnreadEntries)")
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
