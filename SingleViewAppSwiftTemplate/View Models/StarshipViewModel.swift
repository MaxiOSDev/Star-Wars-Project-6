//
//  StarshipViewModel.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

// Starship View Model

enum StarshipProfileItemType {
    case home
    case cost
    case height
    case eyeColor
    case hairColor
}

protocol StarshipItemViewModel {
    var type: StarshipProfileItemType { get }
}

class StarshipViewModeAttributeItem: StarshipItemViewModel {
    
    var type: StarshipProfileItemType {
        return .home
    }
    
    var attributes: [StarshipType]
    
    init(attributes: [StarshipType]) {
        self.attributes = attributes
    }
}

class StarshipViewModel: NSObject, UITableViewDataSource {
    
    var attributes = [StarshipItemViewModel]()
    
    override init() {
        super.init()
        let profileAttributes = StarshipManager.starshipAttributes
        if !profileAttributes.isEmpty {
            let attributesItem = StarshipViewModeAttributeItem(attributes: profileAttributes)
            attributes.append(attributesItem)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = attributes[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CVSCell.reuseIdentifier, for: indexPath) as! CVSCell
            if let item = item as? StarshipViewModeAttributeItem  {
                cell.starshipAttribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.make
                    }
                }
            }
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CostHomeCell.reuseIdentifier, for: indexPath) as! CostHomeCell
            if let item = item as? StarshipViewModeAttributeItem  {
                cell.starshipAttribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.cost
                    }
                }
            }
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeightCostCell.reuseIdentifier, for: indexPath) as! HeightCostCell
            if let item = item as? StarshipViewModeAttributeItem  {
                cell.starshipAttribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        let doubleHeight = Double(attribute.length)
                        if let doubleHeight = doubleHeight {

                            let meterLength =  Measurement(value: doubleHeight, unit: UnitLength.meters)
                            cell.valueLabel.text = "\(meterLength)"
                        }
                    }
                }
            }
            return cell
            
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassEyesCell.reuseIdentifier, for: indexPath) as! ClassEyesCell
            if let item = item as? StarshipViewModeAttributeItem {
                cell.starshipAttribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.shipClass
                    }
                }
            }
            return cell
            
            
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CrewHairCell.reuseIdentifier, for: indexPath) as! CrewHairCell
            if let item = item as? StarshipViewModeAttributeItem {
                cell.starshipAttribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.crewAmount
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CrewHairCell.reuseIdentifier, for: indexPath) as! CrewHairCell
            return cell
        }
    }
}
