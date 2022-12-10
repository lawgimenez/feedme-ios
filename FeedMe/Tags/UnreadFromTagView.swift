//
//  UnreadFromTagView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct UnreadFromTagView: View {
    
    @EnvironmentObject var feedsOversable: FeedsObservable
    var feedID: Int
    
    var body: some View {
        VStack {
            let arrayUnreadEntries = feedsOversable.getUnreadEntries(feedID: feedID)
            let _ = print("UnreadFromTag unread = \(arrayUnreadEntries)")
            List(arrayUnreadEntries) { entry in
                NavigationLink {
                    EntryContentView(entry: entry)
                } label: {
                    EntryRowView(entry: entry)
                }
            }
            .listStyle(.plain)
        }
    }
}

//struct UnreadFromTagView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnreadFromTagView()
//    }
//}
