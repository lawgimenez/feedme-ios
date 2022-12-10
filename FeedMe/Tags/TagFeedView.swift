//
//  TagSubsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import SwiftUI

struct TagFeedView: View {
    
    var tagName: String
    var subsOversable: SubsObservable
    
    var body: some View {
        if let arrayFeedIds = subsOversable.dictTagsList[tagName] {
            let arraySubs = subsOversable.getSubsFromList(arrayFeedIds: arrayFeedIds)
            let _ = print("Array subs = \(arraySubs)")
            List(arraySubs) { sub in
                Text(sub.title)
            }
            .navigationTitle(tagName)
        }
    }
}
