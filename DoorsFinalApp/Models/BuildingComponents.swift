//
//  BuildingComponents.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-04.
//

import SwiftUI

// MARK: - Building Image View
struct BuildingImageView: View {
    let image: String

    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(5)
    }
}

// MARK: - Building Title Bar
struct BuildingTitleBar: View {
    let building: Building
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        HStack {
            FavoriteButton(building: building, favoritesManager: favoritesManager)
            Spacer()
            ShareButton(building: building)
        }
        .padding(.horizontal)
    }
}

// MARK: - Favorite Button
struct FavoriteButton: View {
    let building: Building
    @ObservedObject var favoritesManager: FavoritesManager

    var body: some View {
        Button(action: {
            favoritesManager.toggleFavorite(for: building)
        }) {
            Image(favoritesManager.isFavorite(building: building) ? "heartIcon" : "favoriteOutline")
                .resizable()
                .frame(width: 27, height: 27)
                .foregroundColor(favoritesManager.isFavorite(building: building) ? .red : .gray)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 44, height: 44)
    }
}

// MARK: - Share Button
struct ShareButton: View {
    let building: Building

    var body: some View {
        ShareLink(item: building.shareContent) {
            Image("sharedIconOfficial")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.gray)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Building Card Info
struct BuildingCardInfo: View {
    let building: Building
    var distance: Double?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(building.address)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let distance = distance {
                Text("\(distance, specifier: "%.1f") km away")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text("Distance not available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - Building Card Title
struct BuildingCardTitle: View {
    let building: Building

    var body: some View {
            Text(building.name)
                .font(.headline)
                .fontWeight(.bold)
        }
}


// MARK: - Building Extension
extension Building {
    var shareContent: String {
        var content = "\(name)\n\(address)"
        content += "\n\(description)"
        if let website = website {
            content += "\nMore info: \(website)"
        }
        return content
    }
}
