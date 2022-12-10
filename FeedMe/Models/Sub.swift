//
//  Sub.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/10/22.
//

import Foundation

struct Sub: Decodable, Identifiable {
    
    var id: Int
    var createdAt: String
    var feedID: Int
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case feedID = "feed_id"
        case title
    }
}
