//
//  AssociatedVehiclePV.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/20/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class AssociatedVehiclePV: UIPickerView {
    var modelData = JSONDownloader.vehilceAttributes
}

extension AssociatedVehiclePV: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modelData[row].name
    }
}

extension AssociatedVehiclePV: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modelData.count
    }
}













