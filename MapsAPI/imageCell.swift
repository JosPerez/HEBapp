//
//  imageCell.swift
//  MapsAPI
//
//  Created by jose perez on 29/09/17.
//  Copyright © 2017 jose perez. All rights reserved.
//

import UIKit

class imageCell:UITableViewCell {
    
    
    
    lazy var artImage:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "HEB")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(artImage)
        setup()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        
        
        artImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        artImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        artImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        artImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        
    }
}
