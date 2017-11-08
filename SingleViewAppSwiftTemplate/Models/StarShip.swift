//
//  StarShip.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class StarShip {
    let name: String
    let make: String
    let cost: String
    let length: String
    let shipClass: StarShipClass
    let crewAmount: Int
    
    init(name: String, make: String, cost: String, length: String, shipClass: StarShipClass, crewAmount: Int) {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.shipClass = shipClass
        self.crewAmount = crewAmount
    }
}

extension StarShip {
    convenience init?(json: [String: Any]) {
        struct Key {
            static let name = "name"
            static let make = "model"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let shipClass = "starship_class"
            static let crewAmount = "crew"
        }
        
        guard let shipName = json[Key.name] as? String,
        let shipMake = json[Key.make] as? String,
        let shipCost = json[Key.cost] as? String,
        let shipLength = json[Key.length] as? String,
        let shipClassString = json[Key.shipClass] as? String,
        let shipCrewAmount = json[Key.crewAmount] as? Int,
        let shipClassValue = StarShipClass(name: shipClassString) else { return nil }
        
        self.init(name: shipName, make: shipMake, cost: shipCost, length: shipLength, shipClass: shipClassValue, crewAmount: shipCrewAmount)
    }
}











