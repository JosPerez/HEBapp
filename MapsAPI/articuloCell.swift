//
//  articuloCell.swift
//  MapsAPI
//
//  Created by jose perez on 29/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit

class articuloCell:UITableViewCell {
    
    let artImage:UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "HEB")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let artNombre:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.font  = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Articulo"
        return label
    }()
    
    let artPrice:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.textColor  = UIColor.green
        label.text = "$0.00"
        return label
    }()
    let artCantidad:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.textColor  = UIColor.lightGray
        label.text = "Cant: "
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(imageView!)
        self.contentView.addSubview(artNombre)
        self.contentView.addSubview(artPrice)
        self.contentView.addSubview(artCantidad)
        
        setupCell()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setupCell() {
        let view:[String:Any] = ["image":imageView,"nombre":artNombre,"price":artPrice,"Cantidad":artCantidad]
        
        var layouts = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-20-[nombre]", options: [], metrics: nil, views: view)
        layouts += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-20-[price]-10-[Cantidad]", options: [], metrics: nil, views: view)
        layouts += NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[image]", options: [], metrics: nil, views: view)
        layouts += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nombre]-[price]-|", options: [], metrics: nil, views: view)
        layouts += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nombre]-[Cantidad]-|", options: [], metrics: nil, views: view)
        
        NSLayoutConstraint.activate(layouts)
        
    }
    
}
