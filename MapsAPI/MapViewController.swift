//
//  MapViewController.swift
//  MapsAPI
//
//  Created by jose perez on 29/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import CoreLocation
import GooglePlaces
import Alamofire

class MapViewController: UIViewController, GMSMapViewDelegate {

    var mapView:GMSMapView!
    
    override func loadView() {
       

        // Do any additional setup after loading the view.
        let camara = GMSCameraPosition.camera(withLatitude: 25.727051, longitude: -100.301733, zoom: 13)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camara)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let marker = GMSMarker()
        let coordinate = CLLocationCoordinate2D(latitude: 25.738798, longitude: -100.297090)
        marker.position = coordinate
        marker.title = "HEB on the GO"
        marker.snippet = "Cerca de ti"        
        marker.map = mapView
        
        view = mapView

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
