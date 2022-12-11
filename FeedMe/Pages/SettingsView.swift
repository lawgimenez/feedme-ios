//
//  SettingsView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/11/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isSignOutAlertShown = false
    @State private var isSignedOut = false
    @EnvironmentObject private var authObservables: AuthObservables
    
    var body: some View {
        let _ = print("Auth isSignedOut = \(authObservables.status)")
        if isSignedOut {
        } else {
            List {
                Text("Sign Out")
                    .alert("Are you sure you want to sign out?", isPresented: $isSignOutAlertShown) {
                        Button("Sign Out", role: .destructive) {
                            UserDefaults.standard.set(false, forKey: Keys.Auth.isSignedIn)
                            isSignedOut = true
                        }
                    }
                    .onTapGesture {
                        isSignOutAlertShown = true
                    }
            }
        }
    }
    
    private func signOut () {
        print("FeedMe.app signing out")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
