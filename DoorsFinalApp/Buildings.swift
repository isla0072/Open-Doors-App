//
//  Buildings.swift
//  DoorsFinalApp
//
//  Created by Winter Semester on 2023-11-24.
//

import Foundation

struct Building: Identifiable, Decodable {
    var id = UUID()
    let name: String
    let capital: String?
    let languages: [String]?
    let population: Int?
    let flag: String?
    let region: String?
    let area: Double?

    enum CodingKeys: String, CodingKey {
        case name, capital, languages, population, flag, region, area
    }
}
