//
//  SubsObservables.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import Foundation

class SubsObservable: ObservableObject {
    
    @Published var arraySubs = [Sub]()
    @Published var dictTagsList = [String: [Int]]()
    
    func getSubsFromList(arrayFeedIds: [Int]) -> [Sub] {
        var arraySubsFiltered = [Sub]()
        for feedId in arrayFeedIds {
            let subscriptionFound = arraySubs.filter({ sub in
                sub.feedID == feedId
            })
            if subscriptionFound.first != nil {
                arraySubsFiltered.append(subscriptionFound.first!)
            }
        }
        return arraySubsFiltered
    }
}
