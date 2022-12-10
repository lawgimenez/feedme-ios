//
//  Entry.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import Foundation

struct Entry: Decodable, Identifiable {
    
    var id: Int
    var feedID: Int
    var title: String?
    var url: String?
    var extractedURL: String?
    var author: String?
    var content: String?
    var summary: String
    var published: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case feedID = "feed_id"
        case title
        case url
        case extractedURL = "extracted_content_url"
        case author
        case content
        case summary
        case published
        case createdAt = "created_at"
    }
}
