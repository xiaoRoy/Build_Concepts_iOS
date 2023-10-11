//
//  LocationDataManager.swift
//  Empty Window
//
//  Created by Jerry Li on 2023/6/30.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    
    let locatioanManager = CLLocationManager()
    
    override init() {
        super.init()
        locatioanManager.delegate = self
    }
    
    func requestWhenInUseLocationAuthorization() {
        locatioanManager.requestWhenInUseAuthorization()
    }
    
    func requestAlwaysAuthorization() {
        locatioanManager.requestAlwaysAuthorization()
    }
}
