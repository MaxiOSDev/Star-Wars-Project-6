//
//  JSONDownloader.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

// Character Downloader

class JSONDownloader {
    static let base: String = "https://swapi.co/api/"
    static let peopleResource: String = "people/"
    static let vehicleResoure: String = "vehicles/"
    static let starshipResource: String = "starships/"
    static let planetResouce: String = "planets/"
    static let planetPages: [String] = ["1/","2/","8/", "20/"]
    static var name: String?
    static var profileAttributes = [Attribute]()
    static var vehilceAttributes = [VehicleType]()
    static var starshipAttributes = [StarshipType]()
}

// Character JSON
extension JSONDownloader {
    static func characterDownloader() {
        guard let jsonString = URL(string: "\(self.base)\(self.peopleResource)") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: jsonString) { (data, _, _) in
            guard let data = data else { return }
            do {
                let people = try JSONDecoder().decode(People.self, from: data)
                let characters = people.results
                for character in characters {
                    
                    dump("\(character.name)\(character.homeWorld)")
                    profileAttributes.append(character)
                    
                    for page in planetPages {
                        
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
                            
                            URLSession.shared.dataTask(with: planetString) { data, response, error in
                                if let urlError = error as? URLError {
                                    switch urlError.code {
                                    case .notConnectedToInternet:
                                        print("Connection Down!")
                                    case .networkConnectionLost:
                                        print("Network Connection Lost")
                                    default: break
                                    }
                                }
                            }
                        } else {
                            print("no")
                        }
                    }
                }
                
            } catch JSONDownloaderError.jsonParsingFailure {
                print("Parsing Failure")
            } catch {
                print("\(error)")
            }
        }
        task.resume()
        
        URLSession.shared.dataTask(with: jsonString) { data, response, error in
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    print("Connection Down!")
                case .networkConnectionLost:
                    print("Network Connection Lost")
                default: break
                }
            }
        }
    }
}

// Vehicle JSON
extension JSONDownloader {
    static func vehilceDownload() {
        guard let jsonString = URL(string: "\(self.base)\(self.vehicleResoure)") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: jsonString) { (data, response, error) in
            guard let data = data else { return }
            do {
                let vehicle = try JSONDecoder().decode(Vehicle.self, from: data)
                let vehicles = vehicle.results
    
                for vehicle in vehicles {
                    dump("\(vehicle.name)\(vehicle.length)")
                    vehilceAttributes.append(vehicle)
                    
                }
                
            } catch JSONDownloaderError.jsonParsingFailure {
                print("Parsing Failure")
            } catch {
                print("\(error)")
            }
        }
        task.resume()
        
        URLSession.shared.dataTask(with: jsonString) { data, response, error in
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    print("Connection Down!")
                case .networkConnectionLost:
                    print("Network Connection Lost")
                default: break
                }
            }
        }
    }
    
}

// Starship JSON
extension JSONDownloader {
    static func starshipDownload() {
        guard let jsonString = URL(string: "\(self.base)\(self.starshipResource)") else { return }
        let session = URLSession.shared
        
       
        
        let task = session.dataTask(with: jsonString) { (data, _, error) in
            
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    print("No connection!")
                case .networkConnectionLost:
                    print("Network Connection Lost!")
                default: break
                }
            }
            
            
            guard let data = data else { return }
            
            do {
                let starship = try JSONDecoder().decode(Starship.self, from: data)
                let starships = starship.results
                
                for ship in starships {
                    dump("\(ship.name) & \(ship.length)")
                    
                    starshipAttributes.append(ship)
                    
                }
                
            } catch JSONDownloaderError.jsonParsingFailure {
                print("Parsing Failure")
            } catch {
                print("\(error)")
            }
        }
        task.resume()
        
        URLSession.shared.dataTask(with: jsonString) { data, response, error in
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    print("Connection Down!")
                case .networkConnectionLost:
                    print("Network Connection Lost")
                default: break
                }
            }
        }
    }

}



























