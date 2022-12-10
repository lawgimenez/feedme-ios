//
//  Urls.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import Foundation

class Urls {
    
    static let baseURL = "https://api.feedbin.com"
    static let version = "v2"
    
    public enum Api {
        static let auth = "\(baseURL)/\(version)/authentication.json"
        static let taggings = "\(baseURL)/\(version)/taggings.json"
        static let unread = "\(baseURL)/\(version)/unread_entries.json"
        static let entries = "\(baseURL)/\(version)/entries.json"
        static let unreadEntries = "\(baseURL)/\(version)/entries.json?read=false"
        static let starredEntries = "\(baseURL)/\(version)/entries.json?starred=true"
        static let tags = "\(baseURL)/\(version)/tags.json"
    }
}
