//
//  ArtListController.swift
//  MapsAPI
//
//  Created by jose perez on 29/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit

struct art {
    let nombre:String
    let price: String
    var total:Double
    
    init(nom:String,precio:Double) {
        nombre = nom
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        self.price = formatter.string(for: precio)!
        total = precio
        
    }
}

class ArtListController: UITableViewController {

    
    var totalCompra:Double = 0.0
    var randomProduct:Int!
    let dbArticulos:[art] = [art(nom:"Salsa Picante",precio:9.50),art(nom:"Costillas BBQ",precio:246.0),art(nom:"Tamal Docena",precio:57.50),art(nom: "Barbacoa 1kg",precio:352.0),art(nom:"Pizza Entera",precio:100.00),art(nom:"Alitas",precio:46.00),art(nom:"Pepto Bismol",precio:55.90),art(nom:"Vino",precio:200),art(nom:"Fabuloso 500ml",precio:70.43),art(nom:"Guantes Multiuso",precio:48.00),art(nom:"EScoba Espiga",precio:117),art(nom:"Cubeta",precio:143.00)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(articuloCell.self, forCellReuseIdentifier: "articulo")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            let dbProduct = UInt32(dbArticulos.count)
            randomProduct = Int(arc4random_uniform(dbProduct))
            return randomProduct
        }
        return 1
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var
        
        title = "Total"
        if section == 0 {
            title = "Productos"
        }
        return title
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articulo", for: indexPath) as! articuloCell
        
        if indexPath.section == 0 {
            let dbProduct = UInt32(dbArticulos.count)
            randomProduct = Int(arc4random_uniform(dbProduct))
            cell.artNombre.text = dbArticulos[randomProduct].nombre
            cell.artPrice.text = dbArticulos[randomProduct].price
            cell.imageView?.image = UIImage(named:"HEB")
            let num:UInt32 = 6
            var num1 = Int(arc4random_uniform(num)) % 6
            cell.artCantidad.text = cell.artCantidad.text! + String(num1 + 1)
            totalCompra += dbArticulos[randomProduct].total * Double(num1)
        }else  {
            
            cell.artNombre.text = "Total de Compra : "
            cell.artCantidad.text = ""
            let formatter = NumberFormatter()
            formatter.numberStyle = .currencyAccounting
            cell.artPrice.text = formatter.string(for: totalCompra)
        }

        // Configure the cell...

        return cell
    }
    



}
