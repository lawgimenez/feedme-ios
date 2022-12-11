//
//  UnreadFromTagView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct UnreadFromTagView: View {
    
    @EnvironmentObject var feedsOversable: FeedsObservable
    @State var entryIdRead = 0
    var feedID: Int
    var subTitle: String
    
    var body: some View {
        VStack {
            let arrayUnreadEntries = feedsOversable.getUnreadEntries(feedID: feedID)
            let _ = print("UnreadFromTag unread = \(arrayUnreadEntries)")
            List(arrayUnreadEntries) { entry in
                NavigationLink {
                    EntryContentView(entry: entry, entryIdRead: $entryIdRead)
                } label: {
                    EntryRowView(entry: entry)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle(subTitle)
    }
}

//struct UnreadFromTagView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnreadFromTagView()
//    }
//}
