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

let min = 1
let max = 100

let vehicleCount: Attribute? = nil






