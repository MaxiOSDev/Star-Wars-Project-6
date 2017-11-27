//
//  JSONDownloader.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class JSONDownloader {
    
    enum Endpoint: String {
        case people
        case planets
        case vehicles
        case starships
        
        private var baseURL: String {
            return "https://swapi.co/api/"
        }
        
        private var pageURL: String {
            return "?page="
        }

        var url: URL {
            return URL(string: baseURL + self.rawValue + self.pageURL)!
        }
        
    }
    
    static let base: String = "https://swapi.co/api/"
    static let peopleResource: String = "people/"
    static let vehicleResoure: String = "vehicles/"
    static let starshipResource: String = "starships/"
    static let planetResouce: String = "planets/"

}

extension JSONDownloader {
    static func fetchEndpoint(endpoint: Endpoint, completion: @escaping (Data) -> Void) {
        
        for page in Page.pages {
                let newURL = String("\(endpoint.url)\(page)")
                let url = URL(string: newURL)!
                let session = URLSession.shared
                let task = session.dataTask(with: url) { (data, response, error) in

                    if let data = data {
                        completion(data)
                    } else if let urlError = error as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            print("No connection!")
                        case .networkConnectionLost:
                            print("Network Conncetion Lost!")
                        default: break
                        }
                    }
                    
                }
                task.resume()
        }
}
    
    static func getPlanet(for character: Character) {
        for page in Page.stringPlanetPages {
            if character.homeWorld == self.base + self.planetResouce + page {
                guard let planetString = URL(string: "\(self.base)\(self.planetResouce)\(page)") else { return }
                let planetSession = URLSession.shared
                let planetTask = planetSession.dataTask(with: planetString) { (data, _, _) in
                    guard let data = data else { return }
                    do {
                        let planets = try JSONDecoder().decode(Planet.self, from: data)
                        
                        let planet = planets.name
                        character.homeWorld = planet
                        
                    } catch {}
                }
                planetTask.resume()
            }
        }
    }
}


























