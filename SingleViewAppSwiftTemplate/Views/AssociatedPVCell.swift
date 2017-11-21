//
//  AssociatedPVCell.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/20/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class AssociatedPVCell: UITableViewCell {
    
    static let reuseIdentifier = "AssociatedPVCell"
    
    var vehicleAttribute: Attribute? = nil

    @IBOutlet weak var associatedVehiclePV: UIPickerView!
    @IBOutlet weak var associatedShipPV: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
