//
//  Vehicle.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class Vehicle {
    let name: String
    let make: String
    let cost: Double
    let length: String
    let vehicleClass: VehicleClass
    let crewAmount: Int
    
    init(name: String, make: String, cost: Double, length: String, vehicleClass: VehicleClass, crewAmount: Int) {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crewAmount = crewAmount
    }
}

extension Vehicle {
    convenience init? (json: [String: Any]) {
        struct Key {
            static let name = "name"
            static let model = "model"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let vehicleClass = "vehicle_class"
            static let crewAmount = "crew"
        }
        
        guard let vehicleName = json[Key.name] as? String,
        let vehicleMake = json[Key.model] as? String,
        let vehicleCost = json[Key.cost] as? Double,
        let vehicleLength = json[Key.length] as? String,
        let vehicleClassString = json[Key.vehicleClass] as? String,
        let vehicleClassValue = VehicleClass(name: vehicleClassString),
        let vehicleCrewAmount = json[Key.crewAmount] as? Int else { return nil }
        
        self.init(name: vehicleName, make: vehicleMake, cost: vehicleCost, length: vehicleLength, vehicleClass: vehicleClassValue , crewAmount: vehicleCrewAmount)
    }
}











