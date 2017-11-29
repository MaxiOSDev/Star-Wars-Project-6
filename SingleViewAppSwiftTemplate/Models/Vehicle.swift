//
//  Vehicle.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
// My Vehicle Model
struct VehicleType: Codable {
    let name: String
    let make: String
    let cost: String
    let length: String
    let vehicleClass: String
    let crewAmount: String
    
    enum CodingKeys: String, CodingKey { // Coding Keys to the rescue!
        case name
        case make = "model"
        case cost = "cost_in_credits"
        case length
        case vehicleClass = "vehicle_class"
        case crewAmount = "crew"
    }
}
// Model to enter results
struct Vehicle: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [VehicleType] // Each result is of type VehicleType
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}








