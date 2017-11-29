//
//  Objects.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit
// To distinguish which dataType is which
enum DataType {
    case character
    case vehicle
    case starship
}

enum JSONDownloaderError: Error { // I really feel like I should have more.
    case jsonParsingFailure
    case inProgressFailure
}

enum ExchangeError: Error { // Never Used really..hmm
    case exchangeRateError
    case unitMeasurementError
}

var dataType: DataType? = nil // Hurray for DataType

// How I got my pages for my data. I know Operation could have been used. Honestly a tad confused on how to implement Operation in my project
struct Page {
    static let min = 1
    static let max = 100 // Simply has all number 1-100 and those are the page numbers that I use within my url request
    
    static let planetPages = [Int](min..<max)
    static var stringPlanetPages = planetPages.map {
        String("\($0)/") // Notice the "/" in stringplanet pages and not in pages. Different URL String, checked postman
    }
    
    static let pageResource: String = "?page=" // The page resource
    static var pages = planetPages.map {
        String("\($0)")
    }
}

//let vehicleCount: Character? = nil
// Amazing fix for max length of textfield, Apple really makes us find out own ways. Got this from stack overflow
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
// Extension used for my unit converter
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


