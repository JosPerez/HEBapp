//
//  ViewController.swift
//  MapsAPI
//
//  Created by jose perez on 27/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import CoreLocation
import GooglePlaces
import Alamofire

class ViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    
    let myKey = "AIzaSyDu8P5IoEaxOihhSGKU-oNhWgX5Jpgpe9U"
    let manager = CLLocationManager()
    var myLatitud:CLLocationDegrees!
    var myLongitude:CLLocationDegrees!
    var mapView:GMSMapView!
    var marksArray = [marks]()
    
    lazy var navButton:UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Empezar Navegacion", for: .normal)
        btn.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 51/255, alpha: 1.0)
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(empezarViaje), for: .touchDown)
        return btn
        
    }()
    
    override func loadView() {
        
        
        let imgView = UIImageView(image: UIImage(named:"HEB"))
        imgView.contentMode = .scaleAspectFit
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 65)
        navigationItem.titleView = imgView
        
        
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
        

        let camara = GMSCameraPosition.camera(withLatitude: 25.727051, longitude: -100.301733, zoom: 13)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camara)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        view = mapView
        view.addSubview(navButton)
        view.bringSubview(toFront: navButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Track", style: .done, target: self, action: #selector(traceTheBestRoute))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(mapClear))
        navigationController?.navigationBar.backgroundColor = UIColor(red: 219/255, green: 65/255, blue: 51/255, alpha: 1.0)
        setupButton()
        
    }
    @objc func empezarViaje(){
        
        let alert = UIAlertController(title: "Iniciar Viaje", message: "Seguro deseas iniciar viaje? Olvidas algo?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Iniciar", style: .default, handler: {(_) in
            
            let myPos = self.mapView.myLocation?.coordinate
            
            let navCamara = GMSCameraPosition.camera(withTarget: myPos!, zoom: 15, bearing: 90, viewingAngle: 45)
            self.mapView.animate(to: navCamara)
        })
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func setupButton(){
        navButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -17).isActive = true
        navButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -62).isActive = true
        navButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        navButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        
    }
    
    @objc func traceTheBestRoute() {
    
        if marksArray.count > 0 {
             getTheSuccesor()
            for index in 0..<(marksArray.count - 1) {
                
                let lat = marksArray[index].marks.position.latitude
                let lon = marksArray[index].marks.position.longitude
                let lat2 = marksArray[index+1].marks.position.latitude
                let lon2 = marksArray[index+1].marks.position.longitude
                let begin = CLLocation(latitude: lat, longitude: lon)
                let end = CLLocation(latitude: lat2, longitude: lon2)
                drawRoute(pointA: begin, pointB: end)
            }
            
        }else  {
            
        }
        
    }

    @objc func mapClear() {
        mapView.clear()
        marksArray.removeAll()
        let myPos = self.mapView.myLocation?.coordinate
        let navCamara = GMSCameraPosition.camera(withTarget: myPos!, zoom: 14)
        mapView.animate(to: navCamara)
    }
    
    func drawRoute(pointA:CLLocation, pointB:CLLocation){
        
        let origin = "\(pointA.coordinate.latitude),\(pointA.coordinate.longitude)"
        let destination = "\(pointB.coordinate.latitude),\(pointB.coordinate.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON(completionHandler:{ (response) in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSMutablePath(fromEncodedPath: points!)
                let polyline = GMSPolyline(path: path)
                polyline.strokeWidth = 3
                polyline.strokeColor = self.getRandomColor()
                polyline.map = self.mapView
            }
            
        })
        
    }
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    func getTheSuccesor(){
        
        var markers = [marks]()
        let marker = GMSMarker()
        marker.position = (mapView.myLocation?.coordinate)!
        markers.append(marks(mark: marker, pointA: marker.position, pointB: marker.position))
        marksArray = marksArray.sorted(by: {$0.distance > $1.distance})
        markers.append(marksArray.first!)
        marksArray.removeFirst()
        
        while(!marksArray.isEmpty){
            
            let currentPos = markers.last?.marks.position
            marksArray.map({(marks) -> Void in
                    marks.distancia(pointA: currentPos!)
            })
            marksArray = marksArray.sorted(by: {$0.distance < $1.distance})
            markers.append(marksArray.first!)
            marksArray.removeFirst()
        }
        
        marksArray = markers
        
    }
    
    //MARK GoogleAPI -- mapView
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        let marker = GMSMarker()
        if marksArray.count > 3 {
            mapView.clear()
            marksArray.removeAll()
        }
        marker.position = coordinate
        marker.title = "Persona \(marksArray.count + 1)"
        marker.snippet = String(marksArray.count + 1)
        marker.map = mapView
        
        let mark = marks(mark: marker, pointA: (mapView.myLocation?.coordinate)!, pointB: marker.position)
        
        marksArray.append(mark)
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        
        let view = ArtListController()
        view.navigationItem.title = marker.title
        navigationController?.pushViewController(view, animated: true)
        
    }
}



