//
//  PeopleManager.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

struct PeopleManager {
    
    static var profileAttributes = [Character]()
    static var characterLengthDictionary = [String: String]()
    static var characterDictionary = [String: Double]()
    static func fetchPeople() -> [Character] {
        JSONDownloader.fetchEndpoint(endpoint: .people) { (data) in
            DispatchQueue.main.async {
                do {
                    let people = try JSONDecoder().decode(People.self, from: data)
                    let characters = people.results
                    
                    for character in characters {
                        characterLengthDictionary.updateValue(character.height!, forKey: character.name!)
                        for (key, value) in characterLengthDictionary {
                            if let valueDouble = Double(value) {
                                characterDictionary.updateValue(valueDouble, forKey: key)
                                
                            }
                        }
                        
                        
                        JSONDownloader.getVehicle(for: character)
                        print("IN MANAGER \(character.name)\(character.vehicles)")
                        JSONDownloader.getPlanet(for: character)
                        profileAttributes.append(character)
                    }
                    
                } catch {}
            }
        }
        
        return profileAttributes
    }
}
