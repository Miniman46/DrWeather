//
//  LocationManager.swift
//  DrWeather
//
//  Created by Chris Rea & Josiah Doles on 4/12/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first?.coordinate else {
            print("Error LM1: No location data available.")
            return
        }
        location = currentLocation
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error LM1: Failed to retrieve location data.", error.localizedDescription)
        isLoading = false
    }
}
