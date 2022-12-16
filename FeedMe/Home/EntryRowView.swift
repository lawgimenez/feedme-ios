//
//  EntryRowView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct EntryRowView: View {
    
    var entry: Entry
    
    var body: some View {
        VStack {
            if let title = entry.title {
                Text(title)
                    .font(.system(size: 14).bold())
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
            }
            if let author = entry.author {
                Text(author)
                    .font(.system(size: 12))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
            }
            Text(entry.summary)
                .font(.system(size: 12))
                .multilineTextAlignment(.leading)
        }
    }
}
