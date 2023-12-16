//
//  MapScreenView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-20.
//

import SwiftUI

struct MapScreenView: View {
    @State private var selectedBuilding: Building?
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ZStack {
            MapView(buildings: favoritesManager.buildings, selectedBuilding: $selectedBuilding)
                .edgesIgnoringSafeArea(.all)

            VStack {
                headerView
                Spacer()
            }
        }
        .sheet(item: $selectedBuilding) { building in
            BuildingView(building: building)
        }
    }

    private var headerView: some View {
        HStack {
            Image("ic_logo")
                .resizable()
                .frame(width: 70, height: 50)
            Text("Map")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.blue)
    }
}

