//
//  HomeView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var arrayTaggings = [Tag]()
    
    var body: some View {
        VStack {
            List(arrayTaggings) { tag in
                Text(tag.name)
            }
        }.task {
            await getTaggings()
        }
    }
    
    private func getTaggings() async {
        if let url = URL(string: Urls.Api.taggings) {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
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
