//
//  UserViewController.swift
//  MapsAPI
//
//  Created by jose perez on 29/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps


struct dato {
    
    let title:String!
    let subtitle:String!
    let image:String!
    
    init(titulo:String,subtitulo:String,img:String) {
        title = titulo
        subtitle = subtitulo
        image = img
    }
}

class UserViewController: UITableViewController {

    let datos = [dato(titulo: "Digital Coupons", subtitulo: "Redeem Coupons in store",img: "money"),dato(titulo: "Products", subtitulo: "Browse products across all store",img: "cart"),dato(titulo: "Ahi te voy", subtitulo: "",img: "car")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(imageCell.self, forCellReuseIdentifier: "user")
        tableView.register(articuloCell.self, forCellReuseIdentifier: "articulo")
        
        
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var row:Int!
        
        if section == 0 {
            row  = 1
        }else {
             row = 3
        }
        
        return row
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! imageCell
            cell.artImage.image = UIImage(named:"photo")
             return cell
            
        }else  {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "articulo", for: indexPath) as! articuloCell
            cell2.artNombre.text = datos[indexPath.row].title
            cell2.artPrice.textColor = UIColor.black
            cell2.artPrice.text = datos[indexPath.row].subtitle
            cell2.artImage.image = UIImage(named: datos[indexPath.row].image)
            cell2.artCantidad.text = ""
             return cell2
            
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                navigationController?.pushViewController(ProductoPickerController(), animated: true)
            }else if indexPath.row == 2 {
//                var map = ViewController()
//
//                let carLoc = CLLocationCoordinate2D(latitude: 25.738296, longitude: -100.295588)
//                let marker = GMSMarker()
//                marker.position = carLoc
//                marker.title = "Carro"
//                marker.snippet = "Mas cerca de ti"
//                marker.icon = UIImage(named: "uber")
//                marker.map = map.mapView
//                let myPos = CLLocationCoordinate2D(latitude: 25.735471, longitude: -100.298172)
//                let mark = marks(mark: marker, pointA: myPos, pointB: carLoc)
//                map.marksArray.append(mark)
//                navigationController?.pushViewController(map, animated: true)

                navigationController?.pushViewController(MapViewController(), animated: true)
            }
        }
    }

    

}
