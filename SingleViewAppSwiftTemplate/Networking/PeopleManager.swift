//
//  PeopleManager.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
// Character Manager
struct PeopleManager {
    
    static var profileAttributes = [Character]() // Holds all Characters
    static var characterLengthDictionary = [String: String]() // Needed dictionary for converting Metric to Feet
    static var characterDictionary = [String: Double]() // Needed dictionary for converting Metric to Feet
    // Fetches All Characters
    static func fetchPeople() -> [Character] {
        // That method that retrieves endpoint
        JSONDownloader.fetchEndpoint(endpoint: .people) { (data) in
            DispatchQueue.main.async {
                do {
                    let people = try JSONDecoder().decode(People.self, from: data) // Yay for swift 4!
                    let characters = people.results
                    for character in characters { // The way I updated values for dictionarys form string: double to string: string
                        characterLengthDictionary.updateValue(character.height!, forKey: character.name!)
                        for (key, value) in characterLengthDictionary {
                            if let valueDouble = Double(value) {
                                characterDictionary.updateValue(valueDouble, forKey: key)
                                
                            }
                        }
                        
                        JSONDownloader.getVehicle(for: character) // Gets Associated Vehicles
                        JSONDownloader.getStarShip(for: character) // Gets Associated Starships
                        JSONDownloader.getPlanet(for: character) // Gets Homeworld
                        profileAttributes.append(character) // Appends to profileAttributes array
                    }
                    
                } catch JSONDownloaderError.jsonParsingFailure { // Error Handling
                    print("Parsing Failure!")
                } catch  {
                    print("\(error)")
                }
            }
        }
        
        return profileAttributes
    }
}
