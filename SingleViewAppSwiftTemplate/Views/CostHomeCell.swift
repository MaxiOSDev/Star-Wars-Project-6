//
//  BornMakeCell.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class CostHomeCell: UITableViewCell {
    
    static let reuseIdentifier = "CostHomeCell"
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    
    var attribute: Character? {
        didSet {
            titleLabel.text = "Home"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var vehicleAttribute: VehicleType? {
        didSet {
            titleLabel.text = "Cost"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var starshipAttribute: StarshipType? {
        didSet {
            titleLabel.text = "Cost"
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
