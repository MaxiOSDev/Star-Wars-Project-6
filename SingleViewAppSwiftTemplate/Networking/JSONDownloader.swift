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
    
    static let semaphore = DispatchSemaphore(value: 0)
    
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
         //       semaphore.signal()
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
            //    semaphore.wait()
            
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
    
    static func getVehicle(for character: Character) {
        for page in Page.stringPlanetPages {
            for var vehicle in character.vehicles {
                if vehicle == self.base + self.vehicleResoure + page {
                    guard let vehicleString = URL(string: "\(self.base)\(self.vehicleResoure)\(page)") else { return }
                    let session = URLSession.shared
                    let vehicleTask = session.dataTask(with: vehicleString) { (data, _, error) in
                        guard let data = data else { return }
                        do {
                            
                            print("BEFORE \(vehicle)")
                            
                            let vehicles = try JSONDecoder().decode(VehicleType.self, from: data)
                            
                            vehicle = vehicles.name
                            print("AFTER: \(vehicle)")
                            
                            character.associatedVehicles.append(vehicle)
                            
                        } catch JSONDownloaderError.jsonParsingFailure {
                            print("Parsing Failure!")
                        } catch  {
                            print("\(error)")
                        }
                    }
                    
                    vehicleTask.resume()
                }
            }
        }
    }
    
    static func getStarShip(for character: Character) {
        for page in Page.stringPlanetPages {
            for var starship in character.starships {
                if starship == self.base + self.starshipResource + page {
                    guard let starshipString = URL(string: "\(self.base)\(self.starshipResource)\(page)") else { return }
                    let session = URLSession.shared
                    let shipTask = session.dataTask(with: starshipString) { (data, _, error) in
                        guard let data = data else { return }
                        do {
                            print("Before \(starship)")
                            
                            let starships = try JSONDecoder().decode(StarshipType.self, from: data)
                            
                            starship = starships.name
                            print("AFTER: \(starship)")
                            
                            character.associatedStarships.append(starship)
                        } catch JSONDownloaderError.jsonParsingFailure {
                            print("Parsing Failure!")
                        } catch  {
                            print("\(error)")
                        }
                        
                    }
                    
                    shipTask.resume()
                }
            }
        }
    }
}


























