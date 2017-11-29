//
//  HeightCostCell.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

// Cells for TableView

class HeightCostCell: UITableViewCell {
    
    static let reuseIdentifier = "HeightLengthCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var measurementTypeLabel: UILabel!
    
    var attribute: Character? {
        didSet {
            titleLabel.text = "Height"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var vehicleAttribute: VehicleType? {
        didSet {
            titleLabel.text = "Length"
            //        valueLabel.text = attribute?.homeWorld
        }
    }
    
    var starshipAttribute: StarshipType? {
        didSet {
            titleLabel.text = "Length"
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
