//
//  EntryContentView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct EntryContentView: View {
    
    var entry: Entry
    
    var body: some View {
        let _ = print(entry.extractedURL)
        if let content = entry.content {
            ScrollView {
                Text(content.html2String)
                    .padding(10)
            }
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

