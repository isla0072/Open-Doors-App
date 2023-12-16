//
//  BuildingCardView.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-22.
//

import SwiftUI

struct BuildingCardView: View {
    var building: Building
    var distance: Double?

    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var isFavorite = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            BuildingImageView(image: building.image)
            HStack {
                FavoriteButton(building: building, favoritesManager: favoritesManager)
                ShareButton(building: building)
                Spacer()
                BuildingCardTitle(building: building)
            }
            BuildingCardInfo(building: building, distance: distance)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: .gray, radius: 5, x: 0, y: 0)
    }
}
