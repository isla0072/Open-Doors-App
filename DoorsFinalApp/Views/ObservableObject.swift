//
//  ObservableObject.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-04.
//

import Foundation

class LanguageObserver: ObservableObject {
    @Published var favoritesManager: FavoritesManager
    var languagesManager: LanguagesManager

    init(favoritesManager: FavoritesManager, languagesManager: LanguagesManager) {
        self.favoritesManager = favoritesManager
        self.languagesManager = languagesManager

        NotificationCenter.default.addObserver(forName: .languageDidChange, object: nil, queue: .main) { [weak self] _ in
            self?.favoritesManager.buildings = DataManager.loadBuildings(language: self?.languagesManager.currentLanguage ?? "en")
        }
    }
}
