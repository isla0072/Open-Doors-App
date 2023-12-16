//
//  Building.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-11-26.
//

import Foundation

struct LanguageWrapper: Codable {
    var language: String
    var version: Int
    var year: Int
    var buildings: [Building]
}

struct Amenity: Codable, Hashable {
    let name: String
    let imageName: String
    let isVisible: Bool
}

struct Building: Codable, Identifiable {
    var id: Int
    var name: String
    var address: String
    var category: String
    var image: String
    var description: String
    var website: String?
    var latitude: Double
    var longitude: Double
    var saturdayStart: String
    var saturdayClose: String
    var sundayStart: String
    var sundayClose: String
    var isShuttle: Bool
    var isPublicWashrooms: Bool
    var isAccessible: Bool
    var isFreeParking: Bool
    var isBikeParking: Bool
    var isPaidParking: Bool
    var isGuidedTour: Bool
    var isFamilyFriendly: Bool
    var isOCTranspoNearby: Bool
    var isOpenSaturday: Bool
    var isOpenSunday: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "buildingId"
        case name, category, address, image, description, website, latitude, longitude, saturdayStart, saturdayClose, sundayStart, sundayClose, isShuttle, isPublicWashrooms, isAccessible, isFreeParking, isBikeParking, isPaidParking, isGuidedTour, isFamilyFriendly, isOCTranspoNearby, isOpenSaturday, isOpenSunday
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
}

struct BuildingsWrapper: Codable {
    var buildings: [Building]
}
