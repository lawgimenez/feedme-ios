//
//  UnreadFromTagView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct UnreadFromTagView: View {
    
    @EnvironmentObject private var feedsObservable: FeedsObservable
    @State var entryIdRead = 0
    var feedID: Int
    var subTitle: String
    
    var body: some View {
        VStack {
            let arrayUnreadEntries = feedsObservable.getUnreadEntries(feedID: feedID)
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
        .onAppear {
            let _ = print("FeedMe.app UnreadFromTagView entryIdRead = \(entryIdRead)")
            if entryIdRead != 0 {
                let indexToBeRemoved = feedsObservable.arrayUnreadEntries.firstIndex(where: {
                    $0.id == entryIdRead
                })
                if let indexToBeRemoved {
                    feedsObservable.arrayUnreadEntries.remove(at: indexToBeRemoved)
                }
            }
        }
        .onDisappear {
            entryIdRead = 0
        }
        .navigationTitle(subTitle)
    }
}
