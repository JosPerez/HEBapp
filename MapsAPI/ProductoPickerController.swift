//
//  ProductoPickerController.swift
//  MapsAPI
//
//  Created by jose perez on 29/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit

class ProductoPickerController: UITableViewController {

    let dbArticulos:[art] = [art(nom:"Salsa Picante",precio:9.50),art(nom:"Costillas BBQ",precio:246.0),art(nom:"Tamal Docena",precio:57.50),art(nom: "Barbacoa 1kg",precio:352.0),art(nom:"Pizza Entera",precio:100.00),art(nom:"Alitas",precio:46.00),art(nom:"Pepto Bismol",precio:55.90),art(nom:"Vino",precio:200),art(nom:"Fabuloso 500ml",precio:70.43),art(nom:"Guantes Multiuso",precio:48.00),art(nom:"EScoba Espiga",precio:117),art(nom:"Cubeta",precio:143.00)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       tableView.register(articuloCell.self, forCellReuseIdentifier: "product")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Terminar", style: .done, target: self, action: #selector(printAlert))
    }
    @objc func printAlert() {
        let alert = UIAlertController(title: "Productos Seleccionados", message: "Tus productos llegaran a ti", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dbArticulos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! articuloCell
        
        cell.artNombre.text = dbArticulos[indexPath.row].nombre
        cell.artPrice.text = dbArticulos[indexPath.row].price
        cell.artImage.image = UIImage(named: "HEB")
        cell.artCantidad.text = ""

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark
            {
                cell.accessoryType = .none
            }
            else
            {
                cell.accessoryType = .checkmark
            }
        }
    }
    

}
