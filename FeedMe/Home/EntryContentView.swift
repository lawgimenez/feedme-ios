//
//  EntryContentView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct EntryContentView: View {
    
    var entry: Entry
    @State private var fullContent = ""
    
    var body: some View {
        ScrollView {
            if !fullContent.isEmpty {
                Text(fullContent.html2String)
                    .padding(10)
            }
        }
        .task {
            await getDataFromExtractedUrl()
        }
    }
    
    private func getDataFromExtractedUrl() async {
        if let url = URL(string: entry.extractedURL) {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
                        let content = try JSONDecoder().decode(Content.self, from: data)
                        print("Content = \(content)")
                        fullContent = content.content
                    } catch {
                        print("HomeView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

extension Data {

    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}


extension String {

    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

