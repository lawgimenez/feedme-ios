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
            Text(content)
        }
    }
}
