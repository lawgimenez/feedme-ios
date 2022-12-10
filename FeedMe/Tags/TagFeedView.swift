//
//  TagSubsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct TagFeedView: View {
    
    var tagName: String
    @EnvironmentObject private var subsObservable: SubsObservable
    @EnvironmentObject private var feedsObservable: FeedsObservable
    
    var body: some View {
        if let arrayFeedIds = subsObservable.dictTagsList[tagName] {
            let arraySubs = subsObservable.getSubsFromList(arrayFeedIds: arrayFeedIds)
            List(arraySubs) { sub in
                NavigationLink {
                    UnreadFromTagView(feedID: sub.feedID).environmentObject(feedsObservable)
                } label: {
                    Text(sub.title)
                }
            }
            .navigationTitle(tagName)
        }
    }
}
