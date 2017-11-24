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
        
        private var planetResource: String {
            return "planets/"
        }

        var url: URL {
            return URL(string: baseURL + self.rawValue)!
        }
        
        var peopleURL: URL {
            return URL(string: baseURL + self.rawValue + self.pageURL)!
        }
        
        var planetURL: URL {
            return URL(string: baseURL + self.rawValue)!
        }
        
    }
    
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
    
    static var profileAttributes = [Character]()
    static var vehilceAttributes = [VehicleType]()
    static var starshipAttributes = [StarshipType]()
    static var associatedVehicles = [String]()
    static var starshipLengthDictonary = [String: String]()
    static var vehicleLengthDictionary = [String: String]()
    static var characterLengthDictionary = [String: String]()
    static var characterDictionary = [String: Double]()
    static var vehicleDictionary = [String: Double]()
    static var starshipDictionary = [String: Double]()
    
    
}

extension JSONDownloader {
    static func fetchEndpoint(endpoint: Endpoint, completion: @escaping (Data) -> Void) {
        for page in Page.pages {
                let newURL = String("\(endpoint.peopleURL)\(page)")
                let url = URL(string: newURL)!
                let session = URLSession.shared
                let task = session.dataTask(with: url) { (data, response, error) in

                    if let data = data {
                        completion(data)
                    } else if let error = error {
                        //handle the error
                    }
                    
                }
                task.resume()
        }
}
    
    static func fetchPlanet(endpoint: Endpoint, completion: @escaping (Data) -> Void) {
        for planet in Page.stringPlanetPages {
            let url = String("\(endpoint.planetURL)\(planet)")
            let planetURL = URL(string: url)!
            let session = URLSession.shared
            let task = session.dataTask(with: planetURL) { (data, response, error) in
                if let data = data {
                    completion(data)
                } else if let error = error {
                    
                }
            }
            task.resume()
        }
    }
}



struct PeopleManager {
    // How could I get the planet urls of each charcter correctly?
    static var profileAttributes = [Character]()
    
    static func fetchPeople() -> [Character] {
        JSONDownloader.fetchEndpoint(endpoint: .people) { (data) in
            
            do {
                let people = try JSONDecoder().decode(People.self, from: data)
                let characters = people.results
                for character in characters {
                    print("\(character.name)\(character.homeWorld)")
                    profileAttributes.append(character)
                    
                }

            } catch {}
        }
        return profileAttributes
    }
}




// Old way of getting JSON Data below


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
                        
                        dump("\(character.name)\(character.homeWorld)\(character.vehicles)")
                        
                        characterLengthDictionary.updateValue(character.height!, forKey: character.name!)
                        for (key, value) in characterLengthDictionary {
                            if let valueDouble = Double(value) {
                                characterDictionary.updateValue(valueDouble, forKey: key)
                                
                            }
                        }
                        profileAttributes.append(character)
                        for var vehicle in character.vehicles {
                            guard let newJsonString = URL(string: "\(self.base)\(self.vehicleResoure)\(page)/") else { return }
                            
                            let associatedVehicleTask = session.dataTask(with: newJsonString) { (data, _, _) in
                                guard let data = data else { return }
                                do {
                                    let attributedVehicles = try JSONDecoder().decode(AttributedVehicle.self, from: data)
                                    let attributedVehicle = attributedVehicles.name
                                    
                                    vehicle = attributedVehicle
                                    associatedVehicles.append(vehicle)
                                } catch {}
                            }
                            associatedVehicleTask.resume()
                        }
                        
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



























