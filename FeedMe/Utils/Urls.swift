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
    }
}
