//
//  ContentView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI

struct ContentView: View {
    @StateObject var favoritesManager = FavoritesManager()
    @StateObject var languagesManager = LanguagesManager()
    @StateObject var languageObserver: LanguageObserver

    init() {
        let favoritesManager = FavoritesManager()
        let languagesManager = LanguagesManager()
        _favoritesManager = StateObject(wrappedValue: favoritesManager)
        _languagesManager = StateObject(wrappedValue: languagesManager)
        _languageObserver = StateObject(wrappedValue: LanguageObserver(favoritesManager: favoritesManager, languagesManager: languagesManager))
    }

    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    HomeView().environmentObject(favoritesManager)
                }
                .tabItem { Label("Home", systemImage: "house") }

                NavigationView {
                    MapScreenView()
                }
                .tabItem { Label("Map", systemImage: "map") }

                NavigationView {
                    SavedScreenView().environmentObject(favoritesManager)
                }
                .tabItem { Label("Saved", systemImage: "suit.heart.fill") }

                NavigationView {
                    MoreView(languagesManager: languagesManager)
                }
                .tabItem { Label("More", systemImage: "ellipsis.circle") }
            }
            .environmentObject(favoritesManager)
            .environmentObject(languagesManager)
        }
    }
}

#Preview {
    ContentView()
}
