//
//  CVSCellViewModel.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/13/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

enum ProfileViewModelItemType {
    case home
    case cost
    case height
    case eyeColor
    case hairColor
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
}

class ProfileViewModeAttributeItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .home
    }
    
    var attributes: [Attribute]
    
    init(attributes: [Attribute]) {
        self.attributes = attributes
    }
}

class CVSViewModel: NSObject, UITableViewDataSource {
    
    var attributes = [ProfileViewModelItem]()
    
    override init() {
        super.init()
        let profileAttributes = JSONDownloader.profileAttributes
        if !profileAttributes.isEmpty {
            let attributesItem = ProfileViewModeAttributeItem(attributes: profileAttributes)
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
            if let item = item as? ProfileViewModeAttributeItem  {
                cell.attribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.birthYear
                    }
                }
            }
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CostHomeCell.reuseIdentifier, for: indexPath) as! CostHomeCell
            if let item = item as? ProfileViewModeAttributeItem  {
                cell.attribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.homeWorld
                    }
                }
            }
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeightCostCell.reuseIdentifier, for: indexPath) as! HeightCostCell
            
            
            if let item = item as? ProfileViewModeAttributeItem  {
                cell.attribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        
                        if  let height = attribute.height, let doubleHeight = Double(height) {
                            let centimeterHeight =  Measurement(value: doubleHeight, unit: UnitLength.centimeters)
                            let meterHeight = centimeterHeight.converted(to: UnitLength.meters)
                            cell.valueLabel.text = "\(meterHeight)"
                            
                        }
                    }
                }
            }
            return cell
            
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ClassEyesCell.reuseIdentifier, for: indexPath) as! ClassEyesCell
            if let item = item as? ProfileViewModeAttributeItem {
                cell.attribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.eyeColor
                    }
                }
            }
            return cell
            
            
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CrewHairCell.reuseIdentifier, for: indexPath) as! CrewHairCell
            if let item = item as? ProfileViewModeAttributeItem {
                cell.attribute = item.attributes[indexPath.row]
                for attribute in item.attributes {
                    if pickerIdentifier == attribute.name {
                        cell.valueLabel.text = attribute.hairColor
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















