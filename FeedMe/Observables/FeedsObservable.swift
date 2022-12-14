//
//  FeedsObservable.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import Foundation

class FeedsObservable: ObservableObject {
    
    @Published var arrayUnreadEntries = [Entry]()
    
    func getUnreadEntries(feedID: Int) -> [Entry] {
//        print("arrayunreadentries = \(arrayUnreadEntries)")
        return arrayUnreadEntries.filter({ sub in
            sub.feedID == feedID
        })
    }
}
