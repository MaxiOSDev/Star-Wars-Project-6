//
//  Objects.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

enum DataType {
    case character
    case vehicle
    case starship
}

enum JSONDownloaderError: Error {
    case jsonParsingFailure
    case inProgressFailure
}

enum ExchangeError: Error {
    case exchangeRateError
    case unitMeasurementError
}

var dataType: DataType? = nil


struct Page {
    static let min = 1
    static let max = 100
    
    static let planetPages = [Int](min..<max)
    static var stringPlanetPages = planetPages.map {
        String("\($0)/")
    }
    
    static let pageResource: String = "?page="
    static var pages = planetPages.map {
        String("\($0)")
    }
}

//let vehicleCount: Character? = nil

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        let c = self.characters
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
}



