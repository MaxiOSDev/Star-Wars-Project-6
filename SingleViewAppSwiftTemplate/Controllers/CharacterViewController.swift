//
//  CharacterViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/10/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

// Warning Huge Controller...MVC LOL

import UIKit

var pickerIdentifier: String? // Identifies picker

class DataViewController: UIViewController, UITextFieldDelegate {
    
    // My view models, thank you Pasan for that tutorial
    fileprivate let viewModel = CVSViewModel()
    fileprivate let vehicleViewModel = VehicleViewModel()
    fileprivate let shipViewModel = StarshipViewModel()
    
    // All characters, vehicles, starships from managers after download
    let characterValues = PeopleManager.profileAttributes
    let vehicleValues = VehicleManager.vehicleAttributes
    let shipValues = StarshipManager.starshipAttributes
    
    // Outlets
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataPickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var smallestCVSLabel: UILabel!
    @IBOutlet weak var largestCVSLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var convertCurrencyLabel: UIButton!
    
    @IBOutlet weak var backArrowButton: UIBarButtonItem!
    
    @IBOutlet weak var avButton: UIButton!
    @IBOutlet weak var asButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // One way of uding the picker view
        dataPickerView.delegate = self
        dataPickerView.dataSource = self
        dataTableView.delegate = self
        // Functions from down below
        dataSource()
        setNavBarTitle()
        setCustomBackImage()
        hideCurrencyConverter()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage() // Customize that nav bar
        DispatchQueue.main.async { // Honestly I feel that this is not needed, since all UI updates happen on main thread? But it is reloading data so placholder text doesn't show  up on load
            self.pickerView(self.dataPickerView, didSelectRow: 0, inComponent: 1)
            self.dataTableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() { // Bad habit of always leaving this
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCustomBackImage() { // Ugly arrow never got it fixed...
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backIcon")
    }
    
    @IBAction func convertUnit(_ sender: Any) { // Converts measurement units depending on dataType
        
        if dataType == DataType.character || dataType == DataType.vehicle {
            characterUnitConverter()
        } else if dataType == DataType.starship {
            starshipUnitConverter()
        }
        
    }
    
    @IBAction func convertCurrency(_ sender: UIButton) { // Converts Currency of credits to usd
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.dataTableView.cellForRow(at: indexPath) as! CostHomeCell
        
        if cell.valueLabel.text == "unknown" { // Lol cannot convert unknown cost
            let alert = UIAlertController(title: "Error!", message: "Cannot Convert Unknown Credit", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Understood", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        showAlertWithTwoTextFields() // How the user enters text :)
    }
    
    @IBAction func dismissDataVC(_ sender: Any) { // Self explanatory
        dismiss(animated: true, completion: nil)
    }
    // Transfers associated data from each character to model popup :)
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let assocaitedVehiclesVC = segue.destination as? AVPopUpController {
            // All kinds of different scenarios, probably could have done it better with rawValues, but I was just tired at this point
            for character in characterValues {
                if pickerIdentifier == character.name && character.associatedVehicles.isEmpty == false && character.associatedStarships.isEmpty == false {
                    assocaitedVehiclesVC.avLabelText = "Vehicles: \(character.associatedVehicles.minimalDescription)\n Starships: \(character.associatedStarships.minimalDescription)"
                    
                } else if pickerIdentifier == character.name && character.associatedVehicles.isEmpty == false && character.associatedStarships.isEmpty == true {
                    assocaitedVehiclesVC.avLabelText = "Vehicles: \(character.associatedVehicles.minimalDescription)\n Starships: No Assocaited Starships"
                } else if pickerIdentifier == character.name && character.associatedStarships.isEmpty == false && character.associatedVehicles.isEmpty == true {
                    assocaitedVehiclesVC.avLabelText = "Vehicles: No Associated Vehicles\n Starships: \(character.associatedStarships.minimalDescription)"
                } else if pickerIdentifier == character.name && character.associatedStarships.isEmpty == true && character.associatedVehicles.isEmpty == true {
                    assocaitedVehiclesVC.avLabelText = "No Associated Vehicles or Starships"
                }
                
            }
            
        }
    }
    
    @IBAction func segueToPopUp(_ sender: UIButton) { // Model POPUPS!
        if sender == avButton {
            performSegue(withIdentifier: "PopupSegue", sender: self)
        } else if sender == asButton {
            performSegue(withIdentifier: "PopupSegue", sender: self)
        }
    }
    
    
}



extension DataViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate { // Keeping some things seperate I suppose
    
    func numberOfSections(in tableView: UITableView) -> Int { // TableView Sections
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { // Picker View Components
        return 1
    }
    
    
    // First go at picker view implementation
    // The amount of rows in picker view are the amount of characters of vehicles or starships
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
    
    // Populates Name into picker view of characters, or vehicles, or starships
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
    
    // For what shows up when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if dataType == DataType.character {
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = self.dataTableView.cellForRow(at: indexPath) as? CostHomeCell {
                pickerIdentifier = characterValues[row].name // Picker Identifier in action
                cell.usdLabel.isHidden = true // Characters don't have cost
                cell.creditsLabel.isHidden = true // Above
               isAssociatedButtonHidden()
            }
        } else if dataType == DataType.vehicle {
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = self.dataTableView.cellForRow(at: indexPath) as? CostHomeCell {
                pickerIdentifier = vehicleValues[row].name
                hideCurrencyConverter()
                isAssociatedButtonHidden()
                cell.creditsLabel.textColor = .white // UI Updates for credits or usd
                cell.usdLabel.textColor = .lightGray
                convertCurrencyLabel.isEnabled = true // Because After a new vehicle is selected, you can convert yet again from credits to usd
            }
        } else {
            // Starships
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = self.dataTableView.cellForRow(at: indexPath) as? CostHomeCell {
                pickerIdentifier = shipValues[row].name
                hideCurrencyConverter()
                isAssociatedButtonHidden()
                cell.creditsLabel.textColor = .white
                cell.usdLabel.textColor = .lightGray
                convertCurrencyLabel.isEnabled = true
            }
            
        }
        

        
            nameLabel.text = pickerIdentifier // Stackoverflow to the rescue with the picker Identifier
        
            dataTableView.reloadData() // Reload all Table View data after new name is selected
        
    }
    
    
    
    
    func printCharacterValues() { // For testing purposes
        for character in characterValues {
            print("I AM THE VALUES \(character.name) \(character.vehicles)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { // Customizing tableview
        cell.backgroundColor = .clear
    }
    
    
    
    // Very important alert that has textFields, please ignore my horrible naming, It used to have two textfields not one
        func showAlertWithTwoTextFields() {
            
            let alertController = UIAlertController(title: "Set Exchange Rate", message: "Set Galatic Credit Rate to USD", preferredStyle: .alert)
            
            let showAlertMessegeToUser = UIAlertController(title: "Alert!", message: "Field should not be empty, Please enter an exchange rate", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Understood", style: .default, handler: nil)
            
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
                
                    showAlertMessegeToUser.addAction(okayAction)
                
                
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Exchange Rate"
                textField.keyboardType = UIKeyboardType.numberPad
                textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
                textField.maxLength = 6
                textField.delegate = self
                
            }
            
            
           
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            alertController.actions[0].isEnabled = false
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    
    
    // Helper Methods
    
    func textChanged(_ sender: Any) { // So convert button in alert controller is not enabled with no text inputed or alot of zeros.
        let textField = sender as! UITextField
        var resp: UIResponder! = textField
        while !(resp is UIAlertController) { resp = resp.next }
        let alert = resp as! UIAlertController
        alert.actions[0].isEnabled = (textField.text != "" && textField.text != "0" && textField.text != "00" && textField.text != "000" && textField.text != "0000" && textField.text != "00000" && textField.text != "000000" && textField.text != "0000000") // Honestly the zero part had me scratching my head, so I limited the length of textfield and then inputed these ugly checks for many zeros
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // So noone with a keyboard outside of an iphone can use it. HA only numbers allowed
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    
    
    func hideCurrencyConverter() { // Hides Currency Converter for character
       // Characters have no cost..unless if they are slaves. There are slaves in starwars by the empire
        if dataType == DataType.character {
            convertCurrencyLabel.isHidden = true
        }
        
        
    }
    
    // Hides Associated buttons for vehicles and starships. Could have done more like Vehicles And Starships with associated characters too, but not part of project
    func isAssociatedButtonHidden() {
        var array = [avButton, asButton]
        if dataType == DataType.character {
            for button in array {
                button?.isHidden = false
            }
        } else {
            for button in array {
                button?.isHidden = true
            }
        }
    }
    
    // The following use what those dictionaries in my Managers were ;)
    
    // Smallest Character
    func smallestCharacter() {
        if dataType == DataType.character {
            let smallest = PeopleManager.characterDictionary.min { a, b in a.value < b.value }
            smallestCVSLabel.text = smallest?.key
        }
    }
    // Largest Character
    func largestCharacter() {
        if dataType == DataType.character {
            let largest = PeopleManager.characterDictionary.max { a, b in a.value < b.value }
            largestCVSLabel.text = largest?.key
        }
    }
    // Smallest Ship
    func smallestShip() {
        if dataType == DataType.starship {
            let smallest = StarshipManager.starshipDictionary.min { a, b in a.value < b.value }
            smallestCVSLabel.text = smallest?.key
        }
    }
    // Largest Ship
    func largestShip() {
        if dataType == DataType.starship {
            let largest = StarshipManager.starshipDictionary.max { a, b in a.value < b.value }
            largestCVSLabel.text = largest?.key
        }
    }
    
    // Smallest Vehicle
    func smallestVehicle() {
        if dataType == DataType.vehicle {
            let largest = VehicleManager.vehicleDictionary.min { a, b in a.value < b.value }
            smallestCVSLabel.text = largest?.key
        }
    }
    // Largest Vehicle
    func largestVehicle() {
        if dataType == DataType.vehicle {
            let largest = VehicleManager.vehicleDictionary.max { a, b in a.value < b.value }
            largestCVSLabel.text = largest?.key
        }
    }
    
    
    // The data source.. Very important as well
    // How my view models finally are of use
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
        
        print(" I AM THE DATA SOURCE \(dataTableView.dataSource)") // Testing Purposes
    }
    // Customizations
    func setNavBarTitle() {
        if dataType == DataType.character {
            self.navigationItem.title = "Characters"
        } else if dataType == DataType.vehicle {
            self.navigationItem.title = "Vehicles"
        } else {
            self.navigationItem.title = "Starships"
        }
        
    }
    
    
    // Starship unit Converter also works for vehicles. Please excuse my naming, I know I have to fix it because of guidelines.
    func starshipUnitConverter() {
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = dataTableView.cellForRow(at: indexPath) as! HeightCostCell
        if cell.measurementTypeLabel.text == "Metric" {
            let unit = cell.valueLabel.text?.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+") // That long extension from Objects.swift put to use
            
// This was a big headache I remember every second of it, but it works now!
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
    
    // Character unit converter was different thanks to some meters not converting back to feet for some odd reason
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

// Some extensions that make life easier.

// My unit helpers. Oh how helpful they were
extension Double {
    var metersToFeet: Double {
        return Measurement(value: self, unit: UnitLength.meters).converted(to: UnitLength.feet).value
    }
    
    var feetToMeters: Double {
        return Measurement(value: self, unit: UnitLength.feet).converted(to: UnitLength.meters).value
    }
}
// My textfield restriction helper.
extension String {
    var numbers: String {
        return String(describing: filter { String($0).rangeOfCharacter(from: CharacterSet(charactersIn: ".0123456789")) != nil })
    }
}
// My associated vehicles/starships array helper.
extension Array {
    var minimalDescription: String {
        return map { "\($0)" }.joined(separator: ", ")
    }
}










