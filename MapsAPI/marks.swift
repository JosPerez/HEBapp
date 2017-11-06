//
//  marks.swift
//  MapsAPI
//
//  Created by jose perez on 27/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit
import GoogleMaps


class marks {
    
    var marks:GMSMarker!
    var distance: Double!
    
    init() {
        marks = GMSMarker()
        distance = 9999
    }
    
    init(mark:GMSMarker,pointA:CLLocationCoordinate2D,pointB:CLLocationCoordinate2D){
        
        marks = mark
        distance = GMSGeometryDistance(pointA, pointB)
    }
    
    func distancia(pointA:CLLocationCoordinate2D){
        
       let pointB = self.marks.position
        
        distance = GMSGeometryDistance(pointA, pointB)
    }

    
}
