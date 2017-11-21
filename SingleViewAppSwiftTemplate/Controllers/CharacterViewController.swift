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
    
    var associateVehiclePVModel: AssociatedVehiclePV!
    
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataPickerView: UIPickerView!

    @IBOutlet weak var vehiclePV: UIPickerView!
    @IBOutlet weak var starshipPV: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var smallestCVSLabel: UILabel!
    @IBOutlet weak var largestCVSLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var convertCurrencyLabel: UIButton!
    
    @IBOutlet weak var backArrowButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataPickerView.delegate = self
        dataPickerView.dataSource = self
        dataTableView.delegate = self
        associateVehiclePVModel = AssociatedVehiclePV()
        associateVehiclePVModel.delegate = associateVehiclePVModel
        associateVehiclePVModel.dataSource = associateVehiclePVModel
        dataSource()
        setNavBarTitle()
        setCustomBackImage()
        hideCurrencyConverter()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        DispatchQueue.main.async {
            self.pickerView(self.dataPickerView, didSelectRow: 0, inComponent: 1)
            self.dataTableView.reloadData()
        }
        
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
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.dataTableView.cellForRow(at: indexPath) as! CostHomeCell
        
        if cell.valueLabel.text == "unknown" {
            let alert = UIAlertController(title: "Error!", message: "Cannot Convert Unknown Credit", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Understood", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        showAlertWithTwoTextFields()
    }
    
    @IBAction func dismissDataVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension DataViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
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
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = self.dataTableView.cellForRow(at: indexPath) as? CostHomeCell {
                pickerIdentifier = characterValues[row].name
                cell.usdLabel.isHidden = true
                cell.creditsLabel.isHidden = true
            }
        } else if dataType == DataType.vehicle {
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = self.dataTableView.cellForRow(at: indexPath) as? CostHomeCell {
                pickerIdentifier = vehicleValues[row].name
                hideCurrencyConverter()
                cell.creditsLabel.textColor = .white
                cell.usdLabel.textColor = .lightGray
                convertCurrencyLabel.isEnabled = true
            }
        } else {
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = self.dataTableView.cellForRow(at: indexPath) as? CostHomeCell {
                pickerIdentifier = shipValues[row].name
                hideCurrencyConverter()
                cell.creditsLabel.textColor = .white
                cell.usdLabel.textColor = .lightGray
                convertCurrencyLabel.isEnabled = true
            }
            
        }
        

        
            nameLabel.text = pickerIdentifier
        
            dataTableView.reloadData()
        
    }
    
    

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    
    
    
        func showAlertWithTwoTextFields() {
            
            let alertController = UIAlertController(title: "Set Exchange Rate", message: "Set Galatic Credit Rate to USD", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Convert", style: .default, handler: {
                alert -> Void in
                
                let eventNameTextField = alertController.textFields![0] as UITextField
                eventNameTextField.keyboardType = UIKeyboardType.decimalPad
                
                print("firstName \(String(describing: eventNameTextField.text))")
                
                
                    let indexPath = IndexPath(row: 1, section: 0)
                    let cell = self.dataTableView.cellForRow(at: indexPath) as! CostHomeCell
                
                    let creditAmount = Int(Double(cell.valueLabel.text!)!)
                    print("Credit Amount \(creditAmount)")
                    let exchangeRate = Int(Double(eventNameTextField.text!)!)
                    print("Exchange Rate \(exchangeRate)")
                    cell.valueLabel.text = "\(creditAmount / exchangeRate)"
                    cell.usdLabel.textColor = UIColor.white
                    cell.creditsLabel.textColor = UIColor.lightGray
                    self.convertCurrencyLabel.isEnabled = false
                
                
                if eventNameTextField.text != ""{
                    
                }else{
                    // self.showAlertMessageToUser(title: "Alert", messageToUser: "Fields should not be empty, Please enter given info...")
                    // Show Alert Message to User As per you want
                }
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Exchange Rate"
                textField.keyboardType = UIKeyboardType.numberPad
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    
    
    // Helper Methods
    
    func hideCurrencyConverter() {
       
        if dataType == DataType.character {
            convertCurrencyLabel.isHidden = true
        }
        
        
    }
    
    func smallestCharacter() {
        if dataType == DataType.character {
            let smallest = JSONDownloader.characterDictionary.min { a, b in a.value < b.value }
            smallestCVSLabel.text = smallest?.key
        }
    }
    
    func largestCharacter() {
        if dataType == DataType.character {
            let largest = JSONDownloader.characterDictionary.max { a, b in a.value < b.value }
            largestCVSLabel.text = largest?.key
        }
    }
    
    func smallestShip() {
        if dataType == DataType.starship {
            let smallest = JSONDownloader.starshipDictionary.min { a, b in a.value < b.value }
            smallestCVSLabel.text = smallest?.key
        }
    }
    
    func largestShip() {
        if dataType == DataType.starship {
            let largest = JSONDownloader.starshipDictionary.max { a, b in a.value < b.value }
            largestCVSLabel.text = largest?.key
        }
    }
    
    func smallestVehicle() {
        if dataType == DataType.vehicle {
            let largest = JSONDownloader.vehicleDictionary.min { a, b in a.value < b.value }
            smallestCVSLabel.text = largest?.key
        }
    }
    
    func largestVehicle() {
        if dataType == DataType.vehicle {
            let largest = JSONDownloader.vehicleDictionary.max { a, b in a.value < b.value }
            largestCVSLabel.text = largest?.key
        }
    }
    
    
    
    func dataSource() {
        if dataType == DataType.character {
            dataTableView.dataSource = viewModel
            smallestCharacter()
            largestCharacter()
        } else if dataType == DataType.vehicle {
            dataTableView.dataSource = vehicleViewModel
            smallestVehicle()
            largestVehicle()
        } else {
            dataTableView.dataSource = shipViewModel
            smallestShip()
            largestShip()
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
            

            if let unitValue = unit {
                let doubleValue = Double(unitValue[0].numbers)

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

            
            if unit?.count == 1 {
                if let unitValue = unit {
                    let doubleValue = Double(unitValue[0])
      
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

                

                if let unitValue = unit {
                    let doubleValue = Double(test.numbers)

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
                

                if let unitValue = unit {
                    let doubleValue = Double(unitValue[0])
               
                    if let newDoubleValue = doubleValue {
                        let m = MeasurementFormatter()
                        m.numberFormatter.maximumFractionDigits = 2
                        m.numberFormatter.minimumFractionDigits = 2
                        m.unitOptions = .providedUnit
                        cell.valueLabel.text =  m.string(from: Measurement(value: newDoubleValue.metersToFeet, unit: UnitLength.feet))
                        print("HEREA 2 \(newDoubleValue)")
                        cell.measurementTypeLabel.text = "Imperial"
                    }
                }
                
            } else if cell.measurementTypeLabel.text == "Imperial"{
                let unit = cell.valueLabel.text?.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+")
                
          
                if let unitValue = unit {
                    let doubleValue = Double(unitValue[0])
               
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







