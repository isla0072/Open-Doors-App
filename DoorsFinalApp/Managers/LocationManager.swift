//
//  LocationManager.swift
//  DoorsFinalApp
//
//  Created by Abir Islah on 2023-12-02.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            print("The location authorization was denied")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("There was an error in getting the location: \(error)")
    }
}

extension LocationManager {
    func calculateDistance(to building: Building) -> Double {
        guard let userLocation = lastLocation else { return 0.0 }
        let buildingLocation = CLLocation(latitude: building.latitude, longitude: building.longitude)
        let distanceInMeters = userLocation.distance(from: buildingLocation)
        let distanceInKilometers = distanceInMeters / 1000.0
        return distanceInKilometers
    }
}
