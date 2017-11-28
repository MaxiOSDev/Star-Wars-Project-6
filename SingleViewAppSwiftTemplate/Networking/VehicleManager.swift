//
//  VehicleManager.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

struct VehicleManager {
    
    static var vehicleAttributes = [VehicleType]()
    static var vehicleLengthDictionary = [String: String]()
    static var vehicleDictionary = [String: Double]()
    static func fetchVehicle() -> [VehicleType] {
        JSONDownloader.fetchEndpoint(endpoint: .vehicles) { (data) in
            DispatchQueue.main.async {
                do {
                    let vehicles = try JSONDecoder().decode(Vehicle.self, from: data)
                    let results = vehicles.results
                    for vehicle in results {
                        vehicleLengthDictionary.updateValue(vehicle.length, forKey: vehicle.name)
                        for (key, value) in vehicleLengthDictionary {
                            if let valueDouble = Double(value) {
                                vehicleDictionary.updateValue(valueDouble, forKey: key)
                                
                            }
                        }
                        vehicleAttributes.append(vehicle)
                    }
                } catch JSONDownloaderError.jsonParsingFailure {
                    print("Parsing Failure!")
                } catch  {
                    print("\(error)")
                }
            }
        }
        return vehicleAttributes
    }
    
}
