//
//  Objects.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

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





