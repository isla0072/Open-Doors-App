//
//  HomeView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI
import CoreLocation

enum SortOption {
    case name, distance
}

struct HomeView: View {
    private let outerPadding: CGFloat = 16
    private let innerPadding: CGFloat = 12
    
    @State private var searchText: String = ""
    @State private var showingSearchBar = false
    @State private var showingSideMenu = false

    @State private var selectedSortOption: SortOption = .name
    @State private var selectedBuildingCategories = [String: Bool]()
    @State private var selectedBuildingFeatures = [String: Bool]()
    
    @EnvironmentObject var favoritesManager: FavoritesManager
    @EnvironmentObject var languagesManager: LanguagesManager
    @ObservedObject private var locationManager = LocationManager.shared
    
    private var filteredBuildings: [Building] {
        let buildings = favoritesManager.buildings.filter { building in
            matchesSelectedFeatures(building: building) &&
            matchesSelectedCategories(building: building) &&
            (searchText.isEmpty || building.name.localizedCaseInsensitiveContains(searchText))
        }

        return sortBuildings(buildings: buildings)
    }

    var body: some View {
        ZStack {
            VStack {
                headerView
                buildingsList
            }
            if showingSideMenu {
                sideMenu
                    .transition(.move(edge: .trailing))
            }
        }
    }

    private var headerView: some View {
        HStack {
            Image("ic_logo")
                .resizable()
                .frame(width: 70, height: 50)
            Text("Buildings")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            searchBarButton
            sideMenuButton
        }
        .padding(.horizontal)
        .background(Color.blue)
        .foregroundColor(.white)
    }

    private var searchBarButton: some View {
        Button(action: { withAnimation { showingSearchBar.toggle() } }) {
            Image("search")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }

    private var sideMenuButton: some View {
        Button(action: { withAnimation { showingSideMenu.toggle() } }) {
            Image("whiteFilterIcon")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }

    private var buildingsList: some View {
        List(filteredBuildings, id: \.id) { building in
            let distanceToBuilding = locationManager.calculateDistance(to: building)
            NavigationLink(destination: BuildingView(building: building)) {
                BuildingCardView(building: building, distance: distanceToBuilding)
                    .environmentObject(favoritesManager)
            }
        }
        .listStyle(PlainListStyle())
    }

    private var sideMenu: some View {
        SideMenuView(selectedSortOption: $selectedSortOption,
                     selectedBuildingFeatures: $selectedBuildingFeatures,
                     selectedBuildingCategories: $selectedBuildingCategories,
                     onApply: { withAnimation { showingSideMenu = false } })
            .frame(width: 350)
            .offset(x: showingSideMenu ? 0 : UIScreen.main.bounds.width, y: 0)
    }

    private func sortBuildings(buildings: [Building]) -> [Building] {
        switch selectedSortOption {
        case .name:
            return buildings.sorted { $0.name < $1.name }
        case .distance:
            return buildings.sorted {
                let distance1 = locationManager.calculateDistance(to: $0)
                let distance2 = locationManager.calculateDistance(to: $1)
                return distance1 < distance2
            }
        }
    }
    
    private func matchesSelectedCategories(building: Building) -> Bool {
        let activeCategories = selectedBuildingCategories.filter { $0.value }.map { $0.key }
        if activeCategories.isEmpty { return true }
        return activeCategories.contains(building.category)
    }

    private func matchesSelectedFeatures(building: Building) -> Bool {
        let activeFeatures = selectedBuildingFeatures.filter { $0.value }.map { $0.key }
        if activeFeatures.isEmpty { return true }

        for feature in activeFeatures {
            switch feature {
            case "Wheelchair Accessible":
                if !building.isAccessible { return false }
            case "Shuttle Service":
                if !building.isShuttle { return false }
            case "Public Washrooms":
                if !building.isPublicWashrooms { return false }
            case "Free Parking":
                if !building.isFreeParking { return false }
            case "Bike Parking":
                if !building.isBikeParking { return false }
            case "Paid Parking":
                if !building.isPaidParking { return false }
            case "Guided Tours":
                if !building.isGuidedTour { return false }
            case "Family Friendly":
                if !building.isFamilyFriendly { return false }
            case "OC Transpo Nearby":
                if !building.isOCTranspoNearby { return false }
            default:
                continue
            }
        }

        return true
    }
}
