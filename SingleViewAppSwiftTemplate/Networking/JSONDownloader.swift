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
    
    /*
     [REVIEW] The URL could be a little enum
    
     enum Endpoint: String {
     case people
     case vehicles
     case starships
     
         private var baseURL: String {
            return "https://swapi.co/api/"
         }
     
         var url: URL {
            return URL(string: baseURL + self.rawValue)!
         }
     }
    */
    static let base: String = "https://swapi.co/api/"
    static let peopleResource: String = "people/"
    static let vehicleResoure: String = "vehicles/"
    static let starshipResource: String = "starships/"
    static let planetResouce: String = "planets/"
    
    
    
    //[REVIEW] These don't belong here. The networking layer should only handle downloading the data and passing it along to the next object, all the rest should be handled by a "Manager" struct. More about the "Manager" a little farther down.
    static let planetPages = [Int](min..<max)
    static var stringPlanetPages = planetPages.map {
        String("\($0)/")
    }
    static let pageResource: String = "?page="
    static var pages = planetPages.map {
        String("\($0)")
    }
    static var name: String?
    
    static var profileAttributes = [Attribute]()
    static var vehilceAttributes = [VehicleType]()
    static var starshipAttributes = [StarshipType]()
    
    static var starshipLengthDictonary = [String: String]()
    static var vehicleLengthDictionary = [String: String]()
    static var characterLengthDictionary = [String: String]()
    static var characterDictionary = [String: Double]()
    static var vehicleDictionary = [String: Double]()
    static var starshipDictionary = [String: Double]()

    
}

/*
[REVIEW] While this works, it doesn't really make sense to let the networking layer handle all the logic.
 I would create a fetchEndpoint() function which takes the Endpoint enum as a parameter and then just passes the data to the object asking for it.
 
 static func fetchEndpoint(endpoint: Endpoint, completion: @escaping (Data) -> Void) {
    let url = endpoint.url
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
        if let data = data {
            completion(data)
        } else if let error = error {
            //handle the error or pass it along in the completion block
        }
    }
 }
 
 
 I would then create Manager structs for the various types (People, Vehicle and Starship), create methods to fetch and parse the JSON and let this struct pass the JSON to the next object which needs it.
 For example:
 
 struct PeopleManager {
 
    //This can also use a completion block, or just return the array of people. Whatever you like best.
    static func fetchPeople() -> [People] {
        JSONDownloader.fetchEndpoint(endpoint: .people) { data in
            //decode the data to JSON and return the array of people
        }
    }
 }

*/


// Character JSON
extension JSONDownloader {
    static func characterDownloader() {
        for page in pages {
            guard let jsonString = URL(string: "\(self.base)\(self.peopleResource)\(pageResource)\(page)") else { return }
            let session = URLSession.shared
            let task = session.dataTask(with: jsonString) { (data, _, _) in
                guard let data = data else { return }
                do {
                    let people = try JSONDecoder().decode(People.self, from: data)
                    let characters = people.results
                    for character in characters {
                        
                        dump("\(character.name)\(character.homeWorld)")
                        
                        characterLengthDictionary.updateValue(character.height!, forKey: character.name!)
                        for (key, value) in characterLengthDictionary {
                            if let valueDouble = Double(value) {
                                characterDictionary.updateValue(valueDouble, forKey: key)
                                
                            }
                        }
                        profileAttributes.append(character)
                        
                        for page in stringPlanetPages {
                            
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
}

// Vehicle JSON
extension JSONDownloader {
    static func vehilceDownload() {
        
        for page in pages {
            guard let jsonString = URL(string: "\(self.base)\(self.vehicleResoure)\(pageResource)\(page)") else { return }
            let session = URLSession.shared
            
            DispatchQueue.main.async {
                let task = session.dataTask(with: jsonString) { (data, response, error) in
                    
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
                        let vehicle = try JSONDecoder().decode(Vehicle.self, from: data)
                        let vehicles = vehicle.results
                        
                        for vehicle in vehicles {
                            dump("\(vehicle.name)\(vehicle.length)")
                            
                            vehicleLengthDictionary.updateValue(vehicle.length, forKey: vehicle.name)
                            for (key, value) in vehicleLengthDictionary {
                                if let valueDouble = Double(value) {
                                    vehicleDictionary.updateValue(valueDouble, forKey: key)
                                    
                                }
                            }
                            vehilceAttributes.append(vehicle)
                        }
                        
                    } catch JSONDownloaderError.jsonParsingFailure {
                        print("Parsing Failure")
                    } catch {
                        print("\(error)")
                    }
                }
                task.resume()
                
            }
        }
    }
    
}

// Starship JSON
extension JSONDownloader {
    static func starshipDownload() {
        
        for page in pages {
            guard let jsonString = URL(string: "\(self.base)\(self.starshipResource)\(pageResource)\(page)") else { return }
            let session = URLSession.shared
            
            
            DispatchQueue.main.async {
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
                            
                            starshipLengthDictonary.updateValue(ship.length, forKey: ship.name)
                            for (key, value) in starshipLengthDictonary {
                                if let valueDouble = Double(value) {
                                    starshipDictionary.updateValue(valueDouble, forKey: key)
                                }
                            }
                            starshipAttributes.append(ship)
                            
                        }
                        
                    } catch JSONDownloaderError.jsonParsingFailure {
                        print("Parsing Failure")
                    } catch {
                        print("\(error)")
                    }
                }
                task.resume()
                
                
            }
        }
    }

}



























