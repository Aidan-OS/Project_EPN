//
//  Fence.swift
//  Project_EPN
//
//  Created by Aidan Smith on 2016-09-19.
//  Copyright © 2016 ShamothSoft. All rights reserved.
//

import UIKit
import CoreLocation

class Fence: Any {
    
    var name: String
    var center: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var region: CLCircularRegion {
        get {
            return CLCircularRegion(center: self.center, radius: self.radius, identifier: self.name)
        }
    }
    
    init (name: String, center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        self.name = name
        self.center = center
        self.radius = radius
        
    }
}
