//
//  MainView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI



struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject var authObservables = AuthObservables()
    
    var body: some View {
        if authObservables.status == .success || UserDefaults.standard.bool(forKey: Keys.Auth.isSignedIn) {
            NavigationView {
                HomeView()
                    .environmentObject(authObservables)
            }
            .tint(colorScheme == .dark ? .white : .black)
        } else {
            SignInView()
                .environmentObject(authObservables)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
