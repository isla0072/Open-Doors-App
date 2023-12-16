//
//  MapItem.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-04.
//

import Foundation
import MapKit

class BuildingAnnotation: NSObject, MKAnnotation {
    let building: Building
    var coordinate: CLLocationCoordinate2D
    var iconName: String
    var title: String?

    init(building: Building) {
        self.building = building
        self.coordinate = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
        self.iconName = Utilities.getIconName(for: building.category, from: Utilities.mapIcons)
        self.title = building.name
    }
}
