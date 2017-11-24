//
//  CVSCell.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class CVSCell: UITableViewCell {
    
   static let reuseIdentifier = "BornMakeCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var attribute: Character? {
        didSet {
            titleLabel.text = "Born"
    //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var vehicleAttribute: VehicleType? {
        didSet {
            titleLabel.text = "Make"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var starshipAttribute: StarshipType? {
        didSet {
            titleLabel.text = "Make"
            //        valueLabel.text = attribute?.homeWorld
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
