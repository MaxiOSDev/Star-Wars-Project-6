//
//  Characters.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit
// Character WITH SWIFT 4 CODABLE!
// struct "People" is what is used to get to in simple terms the main menu of the json
struct People: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character] // This makes sure the results are of type character, not vehilce, or starship
    
    enum CodingKeys: String, CodingKey { // I believe I do not need this for this one.
        case count
        case next
        case previous
        case results
    }
}
// Characters within array of results model
class Character: Codable {
    var name: String?
    var height: String?
    var hairColor: String?
    var eyeColor: String?
    var birthYear: String?
    var homeWorld: String?
    var vehicles: [String]
    var starships: [String]
    var associatedVehicles: [String] = [] // Holds associatedVehicles
    var associatedStarships: [String] = [] // Holds associatedStarships
    enum CodingKeys: String, CodingKey { // Coding Keys so the json can be read correctly
        case name
        case height
        case hairColor = "hair_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case homeWorld = "homeworld"
        case vehicles
        case starships
    }
}

struct AttributedVehicle: Codable { // AssociatedVehicle*
    let name: String
}
// Used to Decode each homeworld for each chracter
struct Planet: Codable {
    let name: String
}



























