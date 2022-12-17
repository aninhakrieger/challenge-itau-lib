//
//  GeolocationService.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import Foundation
import CoreLocation

protocol LocationDelegate {
    func getLocation(location: CLLocation)
}

class GeolocationService: NSObject, CLLocationManagerDelegate {
    static let shared = GeolocationService()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var delegate: LocationDelegate?
    
    func getGPSLocation() {
      locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
      if CLLocationManager.locationServicesEnabled() {
        locationManager.startUpdatingLocation()
      }
    }
    
    func stopGPSLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        delegate?.getLocation(location: location)
    }
}
