//
//  StarShip.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
// Starship Model within results
struct StarshipType: Codable {
    let name: String
    let make: String
    let cost: String
    let length: String
    let shipClass: String
    let crewAmount: String
    
    enum CodingKeys: String, CodingKey { // To read json correctly
        case name
        case make = "model"
        case cost = "cost_in_credits"
        case length
        case shipClass = "starship_class"
        case crewAmount = "crew"
    }
}
// Outside of results
struct Starship: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarshipType]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}











