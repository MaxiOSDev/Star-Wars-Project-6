//
//  StarshipManager.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
// Starship Manager
struct StarshipManager {
    static var starshipAttributes = [StarshipType]() // Holds all starships
    static var starshipLengthDictonary = [String: String]() // Needed Dictionary to convert from meters to feet
    static var starshipDictionary = [String: Double]() // Needed Dictionary to convert from meters to feet
    static func fetchStarship() -> [StarshipType] {
        JSONDownloader.fetchEndpoint(endpoint: .starships) { (data) in
            DispatchQueue.main.async {
                do {
                    let starships = try JSONDecoder().decode(Starship.self, from: data) // Swift 4!
                    let results = starships.results
                    for starship in results { // Changes from one dictionary to another
                        starshipLengthDictonary.updateValue(starship.length, forKey: starship.name)
                        for (key, value) in starshipLengthDictonary {
                            if let valueDouble = Double(value) {
                                starshipDictionary.updateValue(valueDouble, forKey: key)
                            }
                        }
                        starshipAttributes.append(starship) // adds starship to array
                    }
                } catch JSONDownloaderError.jsonParsingFailure { // Error Handling
                    print("Parsing Failure!")
                } catch  {
                    print("\(error)")
                }
            }
        }
        return starshipAttributes
    }
}
