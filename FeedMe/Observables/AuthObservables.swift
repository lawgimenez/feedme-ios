//
//  AuthObservables.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/11/22.
//

import Foundation

class AuthObservables: ObservableObject {
    
    enum Status {
        case splash
        case success
        case loggedOut
    }
    
    @Published var status: Status = .loggedOut
}
