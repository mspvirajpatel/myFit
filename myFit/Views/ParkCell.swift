//
//  ParkCell.swift
//  myFit
//
//  Created by Winston Maragh on 9/7/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class ParkCell: UITableViewCell {

    @IBOutlet weak var parkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    static let id = "ParkCell"
    
    func configureCell(venue: Business){
        nameLabel.text = venue.name
        typeLabel.text = "\(venue.distance) meters away"
        addressLabel.text = "\(venue.location.address1 ?? ""), \(venue.location.city ?? "") \(venue.location.state ?? ""), \(venue.location.zip_code ?? "")"
        if let imageStr = venue.image_url {
            parkImageView.loadImage(imageURLString: imageStr)
        }
    }


}
