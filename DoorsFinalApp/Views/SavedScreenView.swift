//
//  SavedScreenView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI

struct SavedScreenView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var searchText: String = ""
    @State private var showingSearchBar = false
    
    private let locationManager = LocationManager.shared

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    headerView
                    buildingList
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var headerView: some View {
        HStack {
            Image("ic_logo")
                .resizable()
                .frame(width: 70, height: 50)
            Text("Favorites")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            if showingSearchBar {
                SearchBarView(text: $searchText)
                    .transition(.move(edge: .trailing))
            }
            Button(action: {
                withAnimation {
                    showingSearchBar.toggle()
                }
            }) {
                Image("search")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal)
        .background(Color.blue)
    }

    private var buildingList: some View {
        List(favoriteBuildings.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }, id: \.id) { building in
            let distanceToBuilding = locationManager.calculateDistance(to: building)
            NavigationLink(destination: BuildingView(building: building)) {
                BuildingCardView(building: building, distance: distanceToBuilding)
                    .environmentObject(favoritesManager)
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .trailing))
    }

    private var favoriteBuildings: [Building] {
        var uniqueBuildings = [Int: Building]()
        for building in favoritesManager.buildings where favoritesManager.favorites.contains(building.id) {
            uniqueBuildings[building.id] = building
        }
        return Array(uniqueBuildings.values)
    }
}

