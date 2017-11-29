//
//  VehicleManager.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/27/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
 // Vehicle Manager
struct VehicleManager {
    
    static var vehicleAttributes = [VehicleType]() // Holds all vehicles
    static var vehicleLengthDictionary = [String: String]() // Needed Dictionary to convert meters to feet
    static var vehicleDictionary = [String: Double]() // Needed Dictionary to convert meters to feet
    static func fetchVehicle() -> [VehicleType] {
        JSONDownloader.fetchEndpoint(endpoint: .vehicles) { (data) in
            DispatchQueue.main.async {
                do {
                    let vehicles = try JSONDecoder().decode(Vehicle.self, from: data)
                    let results = vehicles.results
                    for vehicle in results { // changes from one dictionary to another
                        vehicleLengthDictionary.updateValue(vehicle.length, forKey: vehicle.name)
                        for (key, value) in vehicleLengthDictionary {
                            if let valueDouble = Double(value) {
                                vehicleDictionary.updateValue(valueDouble, forKey: key)
                                
                            }
                        }
                        vehicleAttributes.append(vehicle) // adding all vehicles to array
                    }
                } catch JSONDownloaderError.jsonParsingFailure { // Error handling
                    print("Parsing Failure!")
                } catch  {
                    print("\(error)")
                }
            }
        }
        return vehicleAttributes
    }
    
}
