//
//  Characters.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct People: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Attribute]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}

class Attribute: Codable {
    var name: String?
    var height: String?
    var hairColor: String?
    var eyeColor: String?
    var birthYear: String?
    var homeWorld: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case homeWorld = "homeworld"
    }
}

struct Planet: Codable {
    let name: String
}



























