//
//  HomeView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/9/22.
//

import SwiftUI

struct HomeView: View {
    
    enum Pages: String {
        case unread
    }
    
    @State private var selectedTab: Pages = .unread
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UnreadView()
                .tabItem {
                    Label("Unread", systemImage: "house")
                }
        }
        .navigationTitle(selectedTab.rawValue.capitalized)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
