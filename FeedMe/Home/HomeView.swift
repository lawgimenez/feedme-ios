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
        case starred
    }
    
    @State private var selectedTab: Pages = .unread
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UnreadView()
                .tabItem {
                    Label("Unread", systemImage: "list.bullet.circle.fill")
                }
            StarredView()
                .tabItem {
                    Label("Starred", systemImage: "star.fill")
                }
            TagsView()
                .tabItem {
                    Label("Tags", systemImage: "tag.fill")
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
