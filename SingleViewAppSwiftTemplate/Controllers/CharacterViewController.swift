//
//  CharacterViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

var pickerIdentifier: String?

class DataViewController: UIViewController {
    
    
    fileprivate let viewModel = CVSViewModel()
    fileprivate let vehicleViewModel = VehicleViewModel()
    fileprivate let shipViewModel = StarshipViewModel()
    let characterValues = JSONDownloader.profileAttributes
    let vehicleValues = JSONDownloader.vehilceAttributes
    let shipValues = JSONDownloader.starshipAttributes
    
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataPickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var smallestCVSLabel: UILabel!
    @IBOutlet weak var largestCVSLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPickerView.delegate = self
        dataPickerView.dataSource = self
        dataTableView.delegate = self
        dataSource()
        setNavBarTitle()
        setCustomBackImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCustomBackImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backIcon")
    }
    @IBAction func convertUnit(_ sender: Any) {
        if dataType == DataType.character || dataType == DataType.vehicle {
            characterUnitConverter()
        } else if dataType == DataType.starship {
            starshipUnitConverter()
        }
        
    }
    
}

extension DataViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_
        pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        if dataType == DataType.character {
            return characterValues.count
        } else if dataType == DataType.vehicle {
            return vehicleValues.count
        } else {
            return shipValues.count
        }
    }
    
    func pickerView(_
        pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
        if dataType == DataType.character {
            return characterValues[row].name
        } else if dataType == DataType.vehicle {
            return vehicleValues[row].name
        } else {
            return shipValues[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if dataType == DataType.character {
            pickerIdentifier = characterValues[row].name
        } else if dataType == DataType.vehicle {
            pickerIdentifier = vehicleValues[row].name
        } else {
            pickerIdentifier = shipValues[row].name
        }
        
        
            nameLabel.text = pickerIdentifier
            dataTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    // Helper Methods
    
    func smallest() {
        if dataType == DataType.character {
            
        }
    }
    
    func dataSource() {
        if dataType == DataType.character {
            dataTableView.dataSource = viewModel
            
        } else if dataType == DataType.vehicle {
            dataTableView.dataSource = vehicleViewModel
        } else {
            dataTableView.dataSource = shipViewModel
        }
        
        print(" I AM THE DATA SOURCE \(dataTableView.dataSource)")
    }
    
    func setNavBarTitle() {
        if dataType == DataType.character {
            self.navigationItem.title = "Characters"
        } else if dataType == DataType.vehicle {
            self.navigationItem.title = "Vehicles"
        } else {
            self.navigationItem.title = "Starships"
        }
        
    }
    
    func starshipUnitConverter() {
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = dataTableView.cellForRow(at: indexPath) as! HeightCostCell
        if cell.measurementTypeLabel.text == "Metric" {
            let unit = cell.valueLabel.text?.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+")
            
            print("HERE FOR UNIT \(unit)")
            if let unitValue = unit {
                let doubleValue = Double(unitValue[0].numbers)
                print("Double Value \(doubleValue)")
                if let newDoubleValue = doubleValue {
                    let m = MeasurementFormatter()
                    m.numberFormatter.maximumFractionDigits = 2
                    m.unitOptions = .providedUnit
                    cell.valueLabel.text =  m.string(from: Measurement(value: newDoubleValue.metersToFeet, unit: UnitLength.feet))
                    print("HEREA 2 \(newDoubleValue)")
                    cell.measurementTypeLabel.text = "Imperial"
                }
            }

        } else if cell.measurementTypeLabel.text == "Imperial" {
            let unit = cell.valueLabel.text?.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+")
            for units in unit! {
                print(unit)
            }
            
            if unit?.count == 1 {
                if let unitValue = unit {
                    let doubleValue = Double(unitValue[0])
                    print("Double Value \(doubleValue)")
                    if let newDoubleValue = doubleValue {
                        let m = MeasurementFormatter()
                        m.numberFormatter.maximumFractionDigits = 2
                        m.unitOptions = .providedUnit
                        cell.valueLabel.text = m.string(from: Measurement(value: newDoubleValue.feetToMeters, unit: UnitLength.meters))
                        cell.measurementTypeLabel.text = "Metric"
                    }
                }
            } else {
                var test =  "\(unit![0]).\(unit![1])"
                print(test.numbers)
                
                print("HERE FOR UNIT \(unit)")
                if let unitValue = unit {
                    let doubleValue = Double(test.numbers)
                    print("Double Value \(doubleValue)")
                    if let newDoubleValue = doubleValue {
                        let m = MeasurementFormatter()
                        m.numberFormatter.maximumFractionDigits = 2
                        m.unitOptions = .providedUnit
                        cell.valueLabel.text = m.string(from: Measurement(value: newDoubleValue.feetToMeters, unit: UnitLength.meters))
                        cell.measurementTypeLabel.text = "Metric"
                    }
                }
            }
            
        }
    }
    
    func characterUnitConverter() {
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = dataTableView.cellForRow(at: indexPath) as! HeightCostCell
            if cell.measurementTypeLabel.text == "Metric" {
                let unit = cell.valueLabel.text?.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+")
                
                print("HERE FOR UNIT \(unit)")
                if let unitValue = unit {
                    let doubleValue = Double(unitValue[0])
                    print("Double Value \(doubleValue)")
                    if let newDoubleValue = doubleValue {
                        let m = MeasurementFormatter()
                        m.numberFormatter.maximumFractionDigits = 2
                        m.unitOptions = .providedUnit
                        cell.valueLabel.text =  m.string(from: Measurement(value: newDoubleValue.metersToFeet, unit: UnitLength.feet))
                        print("HEREA 2 \(newDoubleValue)")
                        cell.measurementTypeLabel.text = "Imperial"
                    }
                }
                
            } else if cell.measurementTypeLabel.text == "Imperial"{
                let unit = cell.valueLabel.text?.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+")
                
                print("HERE FOR UNIT \(unit)")
                if let unitValue = unit {
                    let doubleValue = Double(unitValue[0])
                    print("Double Value \(doubleValue)")
                    if let newDoubleValue = doubleValue {
                        let m = MeasurementFormatter()
                        m.numberFormatter.maximumFractionDigits = 2
                        m.unitOptions = .providedUnit
                        cell.valueLabel.text =  m.string(from: Measurement(value: newDoubleValue.feetToMeters, unit: UnitLength.meters))
                        print("HEREA 2 \(newDoubleValue)")
                        cell.measurementTypeLabel.text = "Metric"
                    }
                }
            }
    }

    }

extension Double {
    var metersToFeet: Double {
        return Measurement(value: self, unit: UnitLength.meters).converted(to: UnitLength.feet).value
    }
    
    var feetToMeters: Double {
        return Measurement(value: self, unit: UnitLength.feet).converted(to: UnitLength.meters).value
    }
}

extension String {
    var numbers: String {
        return String(describing: filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: ".0123456789")) != nil })
    }
}







