//
//  Utilities.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-04.
//

import Foundation

struct Utilities {
    static let categoryIcons: [String: String] = [
        "Community and/or Care centres": "communityFilter",
        "Religious buildings": "newReligionHandsFilter",
        "Business and/or Foundations": "businessFilter",
        "Embassies": "embassyFilter",
        "Museums, Archives and Historic Sites": "museumsFilter",
        "Academic Institutions": "academicsFilter",
        "Government buildings": "governmentBuildingsFilter",
        "Functional buildings": "functionalFilter",
        "Galleries and Theatres": "galleriresFilter",
        "Sports and Leisure buildings": "sportsFilter",
        "Other": "otherFilter"
    ]
    
    static let amenityIcons: [String: String] = [
        "Wheelchair Accessible": "accessibility",
        "Shuttle Service": "shuttle",
        "Public Washrooms": "washroom",
        "Free Parking": "freeParking",
        "Bike Parking": "bikeracks",
        "Paid Parking": "paidParking",
        "Guided Tours": "guidedTour",
        "Family Friendly": "familyFriendly",
        "OC Transpo Nearby": "ocTranspo"
    ]
    
    static let mapIcons: [String: String] = [
        "Community and/or Care centres": "mapCommunity",
        "Religious buildings": "newReligionFilterMap",
        "Business and/or Foundations": "mapBusiness",
        "Embassies": "mapEmbassy",
        "Museums, Archives and Historic Sites": "mapMuseum",
        "Academic Institutions": "mapAcademic",
        "Government buildings": "mapGovernement",
        "Functional buildings": "mapFunctional",
        "Galleries and Theatres": "mapGalleries",
        "Sports and Leisure buildings": "mapSports",
        "Other": "mapOther"
    ]
    
    static func getIconName(for type: String, from dictionary: [String: String]) -> String {
        return dictionary[type] ?? "governmentBuildingsFilter"
    }
}
