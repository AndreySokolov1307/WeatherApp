//
//  LocationService.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import Foundation
import CoreLocation

class LocationFormatter {
    static let shared = LocationFormatter()
    
    private let geocoder = CLGeocoder()
    
    func cityName(location: CLLocation) async throws -> String {
        let placemark  = try await geocoder.reverseGeocodeLocation(location)
        if let locality = placemark.first?.locality {
            return locality
        } else {
            return ""
        }
    }
}

