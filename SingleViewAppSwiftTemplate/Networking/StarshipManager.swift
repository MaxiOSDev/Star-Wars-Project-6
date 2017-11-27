//
//  StarshipManager.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

struct StarshipManager {
    static var starshipAttributes = [StarshipType]()
    static var starshipLengthDictonary = [String: String]()
    static var starshipDictionary = [String: Double]()
    static func fetchStarship() -> [StarshipType] {
        JSONDownloader.fetchEndpoint(endpoint: .starships) { (data) in
            DispatchQueue.main.async {
                do {
                    let starships = try JSONDecoder().decode(Starship.self, from: data)
                    let results = starships.results
                    for starship in results {
                        starshipLengthDictonary.updateValue(starship.length, forKey: starship.name)
                        for (key, value) in starshipLengthDictonary {
                            if let valueDouble = Double(value) {
                                starshipDictionary.updateValue(valueDouble, forKey: key)
                            }
                        }
                        starshipAttributes.append(starship)
                    }
                } catch {}
            }
        }
        return starshipAttributes
    }
}
