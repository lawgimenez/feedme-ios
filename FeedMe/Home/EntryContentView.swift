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
    @State private var isContentRead = false
    @Binding var entryIdRead: Int
    
    var body: some View {
        VStack {
            ScrollView {
                Text(fullContent)
                    .padding(10)
            }
            Button(action: {
                toggleRead()
            }) {
                let _ = print("isContentRead = \(isContentRead)")
                Image(systemName: isContentRead == true ? "checkmark.circle.fill" : "checkmark.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .task {
            await getDataFromExtractedUrl()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getDataFromExtractedUrl() async {
        if let extractedURL = entry.extractedURL {
            if let url = URL(string: extractedURL) {
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                let task = session.dataTask(with: request) { data, _, _ in
                    if let data = data {
                        do {
                            let content = try JSONDecoder().decode(Content.self, from: data)
                            print("Content = \(content)")
                            DispatchQueue.main.async {
                                fullContent = content.content.html2String
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
    
    private func toggleRead() {
        var httpMethod = "DELETE"
        if !isContentRead {
            // Mark this content as read
            httpMethod = "DELETE"
        } else {
            // If mark as read is untrue
            // Mark it as unread again
            httpMethod = "POST"
        }
        if let url = URL(string: Urls.Api.unread) {
            let json = ["unread_entries": [entry.id]]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            if let dataString = String(bytes: jsonData!, encoding: .utf8) {
                print("JsonData = \(dataString)")
            }
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            let task = session.dataTask(with: request) { _, response, error in
                if let error = error {
                    print(error)
                } else {
                    let statusResponse = response as! HTTPURLResponse
                    print("stat code \(statusResponse.statusCode)")
                    if statusResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            isContentRead.toggle()
                            if isContentRead {
                                entryIdRead = entry.id
                            } else {
                                entryIdRead = 0
                            }
                        }
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

