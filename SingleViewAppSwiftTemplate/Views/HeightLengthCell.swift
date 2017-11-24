//
//  HeightCostCell.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

extension String {
    
    func stringsMatchingRegularExpression(expression exp:String) -> [String]? {
        var strArray:[String]?
        var rangeArray:[NSRange]?
        let strLength = self.characters.count
        var startOfRange = 0
        do {
            let regexString = try NSRegularExpression(pattern: exp, options: [])
            while startOfRange <= strLength {
                let rangeOfMatch = regexString.rangeOfFirstMatch(in: self, options: [], range: NSMakeRange(startOfRange, strLength-startOfRange))
                if let rArray = rangeArray {
                    rangeArray = rArray + [rangeOfMatch]
                }
                else {
                    rangeArray = [rangeOfMatch]
                }
                startOfRange = rangeOfMatch.location+rangeOfMatch.length
                
                
            }
            if let ranArr = rangeArray {
                for r in ranArr {
                    
                    if !NSEqualRanges(r, NSMakeRange(NSNotFound, 0)) {
                        self.index(startIndex, offsetBy: r.length)
                        
                        let r =  self.index(startIndex, offsetBy:r.location)..<self.index(startIndex, offsetBy:r.location + r.length)
                        
                        // return the value
                        let substringForMatch = self.substring(with: r)
                        if let sArray = strArray {
                            strArray = sArray + [substringForMatch]
                        }
                        else {
                            strArray = [substringForMatch]
                        }
                        
                    }
                    
                }
            }
        }
        catch {
            // catch errors here
        }
        
        return strArray
    }
}

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
