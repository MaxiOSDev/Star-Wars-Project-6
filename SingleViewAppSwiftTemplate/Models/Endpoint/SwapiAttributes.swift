//
//  SwapiAttributes.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

protocol SwapiAttribute: QueryItemProvider {
    var attributeName: String { get }
}

extension SwapiAttribute {
    var queryItem: URLQueryItem {
        return URLQueryItem(name: "attribute", value: attributeName)
    }
}

enum PeopleAttribute: String, SwapiAttribute {
    case name
    case birthYear
    case eyeColor
    case gender
    case hairColor
    case height
    case mass
    case skinColor
    case homeworld
    case films
    case species
    case starships
    case vehicles
    case url
    case created
    case edited
    var attributeName: String {
        return self.rawValue
    }
}

enum VehicleAttribute: String, SwapiAttribute {
    case name
    case model
    case vehicleClass
    case manufacturer
    case length
    case costInCredits
    case crew
    case passengers
    case maxAtmospheringSpeed
    case cargoCapacity
    case consumables
    case films
    case pilots
    case url
    case creatred
    case edited
    
    var attributeName: String {
        return self.rawValue
    }
}

enum StarShipAttribute: String, SwapiAttribute {
    case name
    case model
    case starshipClass
    case manufacturer
    case costInCredits
    case length
    case crew
    case passengers
    case maxAtmospheringSpeed
    case hyperdriveRating
    case mglt
    case cargoCapacity
    case consumables
    case films
    case pilots
    case url
    case created
    case edited
    
    var attributeName: String {
        return self.rawValue
    }
}



