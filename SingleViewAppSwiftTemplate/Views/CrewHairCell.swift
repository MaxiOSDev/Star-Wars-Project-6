//
//  CrewHairCell.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class CrewHairCell: UITableViewCell {
    
    static let reuseIdentifier = "CrewHairCell"

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var attribute: Character? {
        didSet {
            titleLabel.text = "Hair"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var vehicleAttribute: VehicleType? {
        didSet {
            titleLabel.text = "Crew"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var starshipAttribute: StarshipType? {
        didSet {
            titleLabel.text = "Crew"
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
