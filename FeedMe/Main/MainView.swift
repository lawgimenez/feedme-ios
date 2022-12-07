//
//  MainView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

enum Status {
    case splash
    case success
    case loggedOut
}

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var status: Status = .loggedOut
    
    var body: some View {
        if status == .success || UserDefaults.standard.bool(forKey: Keys.Auth.isSignedIn) {
            NavigationView {
                HomeView()
            }
            .tint(colorScheme == .dark ? .white : .black)
        } else {
            SignInView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
