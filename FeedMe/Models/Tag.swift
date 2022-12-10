//
//  Tag.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import Foundation

struct Tag: Decodable, Identifiable {
    
    var id: Int
    var feedID: Int?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case feedID = "feed_id"
        case name
    }
}
