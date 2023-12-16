//
//  FavoritesManager.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-28.
//

import Foundation
import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favorites: Set<Int> = []
    @Published var buildings: [Building] = []
    init() {
        self.buildings = DataManager.loadBuildings()
    }
    func toggleFavorite(for building: Building) {
        if favorites.contains(building.id) {
            favorites.remove(building.id)
        } else {
            favorites.insert(building.id)
        }
    }

    func isFavorite(building: Building) -> Bool {
        return favorites.contains(building.id)
    }
}
