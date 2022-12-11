//
//  HomeView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/9/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var subsObservable = SubsObservable()
    @StateObject var feedsObservable = FeedsObservable()
    @EnvironmentObject private var authObservables: AuthObservables
    
    enum Pages: String {
        case unread
        case starred
        case tags
        case subscriptions
        case settings
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
                .tag(Pages.tags)
            SubsView()
                .tabItem {
                    Label("Subscriptions", systemImage: "pencil.circle.fill")
                }
                .tag(Pages.subscriptions)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle.fill")
                }
                .tag(Pages.settings)
                .environmentObject(authObservables)
        }
        .task {
            await getSubs()
        }
        .navigationTitle(selectedTab.rawValue.capitalized)
        .environmentObject(subsObservable)
        .environmentObject(feedsObservable)
    }
    
    private func getSubs() async {
        if let url = URL(string: Urls.Api.subsriptions) {
            let userValue = String(format: "%@:%@", UserDefaults.standard.string(forKey: Keys.Auth.email)!, UserDefaults.standard.string(forKey: Keys.Auth.password)!).data(using: .utf8)?.base64EncodedString()
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request) { data, _, _ in
                if let data = data {
                    do {
//                        if let dataString = String(bytes: data, encoding: .utf8) {
//                            print("Subs = \(dataString)")
//                        }
                        let arraySubs = try JSONDecoder().decode([Sub].self, from: data)
                        DispatchQueue.main.async {
                            subsObservable.arraySubs = arraySubs
                            print("Subs count = \(subsObservable.arraySubs.count)")
                        }
                    } catch {
                        print("SubsView.error = \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
