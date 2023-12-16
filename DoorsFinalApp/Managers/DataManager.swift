//
//  DataManager.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-06.
//

// DataManager.swift

import Foundation

class DataManager {
    static func loadBuildings(language: String = "en") -> [Building] {
        guard let url = Bundle.main.url(forResource: "buildings", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("There was an error when decoding the JSON")
            return []
        }

        do {
            let allData = try JSONDecoder().decode([LanguageWrapper].self, from: data)
            guard let languageData = allData.first(where: { $0.language == language }) else {
                return []
            }

            return languageData.buildings.map { $0.removingSuffixFromImage() }
        } catch {
            print("There was an error when decoding the JSON: \(error)")
            return []
        }
    }
}

private extension Building {
    func removingSuffixFromImage() -> Building {
        var modifiedBuilding = self
        modifiedBuilding.image = image.removingSuffix(".jpg")
        return modifiedBuilding
    }
}

extension String {
    func removingSuffix(_ suffix: String) -> String {
        hasSuffix(suffix) ? String(dropLast(suffix.count)) : self
    }
}
