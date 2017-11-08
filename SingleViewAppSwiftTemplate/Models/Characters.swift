//
//  Characters.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


class Character {
    let name: String
    let dob: String
    let home: String
    let height: String
    let eyes: String
    let hair: String
    
    init(name: String, dob: String, home: String, height: String, eyes: String, hair: String) {
        self.name = name
        self.dob = dob
        self.home = home
        self.height = height
        self.eyes = eyes
        self.hair = hair
    }
    
    
}


extension Character {
    convenience init?(json: [String: Any]) {
        struct Key {
            static let characterName = "name"
            static let birthYear = "birth_year"
            static let homeWorld = "homeworld"
            static let height = "height"
            static let eyes = "eye_color"
            static let hair = "hair_color"
        }
        
        guard let characterName = json[Key.characterName] as? String,
        let birthYear = json[Key.birthYear] as? String,
        let homeWorld = json[Key.homeWorld] as? String,
        let height = json[Key.height] as? String,
        let eyes = json[Key.eyes] as? String,
        let hair = json[Key.hair] as? String else {
            return nil
        }
        self.init(name: characterName, dob: birthYear, home: homeWorld, height: height, eyes: eyes, hair: hair)
    }
}




























