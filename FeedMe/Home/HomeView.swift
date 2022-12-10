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
        case tag
        case subscriptions
    }
    
    @State private var selectedTab: Pages = .unread
    
    var body: some View {
        TabView(selection: $selectedTab) {
            UnreadView()
                .tabItem {
                    Label("Unread", systemImage: "list.bullet.circle.fill")
                }
                .tag(Pages.unread)
            StarredView()
                .tabItem {
                    Label("Starred", systemImage: "star.fill")
                }
                .tag(Pages.starred)
            TagsView()
                .tabItem {
                    Label("Tags", systemImage: "tag.fill")
                }
                .tag(Pages.tag)
            SubsView()
                .tabItem {
                    Label("Subscriptions", systemImage: "pencil.circle.fill")
                }
                .tag(Pages.subscriptions)
        }
        .navigationTitle(selectedTab.rawValue.capitalized)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
