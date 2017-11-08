//
//  Objects.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Max Ramirez on 11/8/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


enum VehicleClass {
    case wheeled
    case repulsorcraft
    case starfighter
    case airspeeder
    case spacePlanetaryBomber
    case assultWalker
    case walker
    case sailBarge
    case repulsorcraftCargoSkiff
    case speeder
    case landingCraft
    case submarine
    case gunship
    case wheeledWalker
    case fireSuppressionShip
    case droidStarfighter
    case airSpeeder // air speeder with the space in between, different than airspeeder
    case droidTank
    case transport
    
    var name: String {
        switch self {
        case .wheeled: return "wheeled"
        case .repulsorcraft: return "repulsorcraft"
        case .starfighter: return "starfighter"
        case .airspeeder: return "airspeeder"
        case .spacePlanetaryBomber: return "space/planetary bomber"
        case .assultWalker:return "assault walker"
        case .walker: return "walker"
        case .sailBarge: return "sail barge"
        case .repulsorcraftCargoSkiff: return  "repulsorcraft cargo skiff"
        case .speeder: return  "speeder"
        case .landingCraft: return "landing craft"
        case .submarine: return "submarine"
        case .gunship: return  "gunship"
        case .wheeledWalker: return "wheeled walker"
        case .fireSuppressionShip: return "fire suppression ship"
        case .droidStarfighter:return "droid starfighter"
        case .airSpeeder:return   "air speeder"
        case.droidTank: return "droid tank"
        case .transport: return "transport"
        }
    }
}

extension VehicleClass {
    init?(name: String) {
        switch name {
        case "wheeled": self = .wheeled
        case "repulsorcraft": self = .repulsorcraft
        case "starfighter": self = .starfighter
        case "airspeeder": self = .airspeeder
        case "space/planetary bomber": self = .spacePlanetaryBomber
        case "assault walker": self = .assultWalker
        case "walker": self = .walker
        case "sail barge": self = .sailBarge
        case "repulsorcraft cargo skiff": self = .repulsorcraftCargoSkiff
        case "speeder": self = .speeder
        case "landing craft": self = .landingCraft
        case "submarine": self = .submarine
        case "gunship": self = .gunship
        case "wheeled walker": self = .wheeledWalker
        case "fire suppression ship": self = .fireSuppressionShip
        case "droid starfighter": self = .droidStarfighter
        case "air speeder": self = .airSpeeder
        case "droid tank": self = .droidTank
        case "transport": self = .transport
        default: return nil
        }
    }
}


enum StarShipClass {
    case starDreadnought // "Star dreadnought"
    case landingCraft // "landing craft"
    case deepSpaceMobileBattlestation // "Deep Space Mobile Battlestation"
    case lightFreighter // "Light freighter"
    case assultStarfighter // "assault starfighter"
    case starfighter // "Starfighter"
    case patrolCraft // "Patrol craft"
    case armedGovernmentTransport // "Armed government transport"
    case escortShip // "Escort ship"
    case starCruiser // "Star Cruiser"
    case assultStarFighter // "Assault Starfighter" Different from top one
    case spaceCruiser // "Space cruiser"
    case yacht // "yacht"
    case spaceTransport // "Space Transport"
    case diplomaticBarge // "Diplomatic barge"
    case freighter // "freighter"
    case starDestroyer // "Star Destroyer"
    case captialShip // "capital ship"
    case transport // "transport"
    case fighter // "fighter"
    case mediumTransport // "Medium transport"
    case droidControlShip // "Droid control ship"
    case assultShip // "assault ship"
    case stardestroyer // "star destroyer" different from top one
    case starFighter // "starfighter" Different from top one
    case corvette // "corvette"
    case cruiser // "cruiser"
    
    var name: String {
        switch self {
        case .starDreadnought: return "Star dreadnought"
        case .landingCraft: return "landing craft"
        case .deepSpaceMobileBattlestation: return "Deep Space Mobile Battlestation"
        case .lightFreighter: return "Light freighter"
        case .assultStarfighter: return "assault starfighter"
        case .starfighter: return "Starfighter"
        case .patrolCraft: return "Patrol craft"
        case .armedGovernmentTransport: return "Armed government transport"
        case .escortShip: return "Escort ship"
        case .starCruiser: return "Star Cruiser"
        case .assultStarFighter: return "Assault Starfighter"
        case .spaceCruiser: return "Space cruiser"
        case .yacht: return "yacht"
        case .spaceTransport: return "Space Transport"
        case .diplomaticBarge: return "Diplomatic barge"
        case .freighter: return "freighter"
        case .starDestroyer: return "Star Destroyer"
        case .captialShip: return "capital ship"
        case .transport: return "transport"
        case .fighter: return "fighter"
        case .mediumTransport: return "Medium transport"
        case .droidControlShip: return "Droid control ship"
        case .assultShip: return "assault ship"
        case .stardestroyer: return "star destroyer"
        case .starFighter: return "starfighter"
        case .corvette: return "corvette"
        case .cruiser: return "cruiser"
        }
    }
}

extension StarShipClass {
    init?(name: String) {
        switch name {
        case "Star dreadnought": self = .starDreadnought
        case "landing craft": self = .landingCraft
        case "Deep Space Mobile Battlestation": self = .deepSpaceMobileBattlestation
        case "Light freighter": self = .lightFreighter
        case "assault starfighter": self = .assultStarfighter // double check
        case "Starfighter": self = .starFighter // double check
        case "Patrol craft": self = .patrolCraft
        case "Armed government transport": self = .armedGovernmentTransport
        case "Escort ship": self = .escortShip
        case "Star Cruiser": self = .starCruiser
        case "Assault Starfighter": self = .assultStarFighter // double check
        case "Space cruiser": self = .spaceCruiser
        case "yacht": self = .yacht
        case "Space Transport": self = .spaceTransport
        case "Diplomatic barge": self = .diplomaticBarge
        case "freighter": self = .freighter
        case "Star Destroyer": self = .starDestroyer
        case "capital ship": self = .captialShip
        case "transport": self = .transport
        case "fighter": self = .fighter
        case "Medium transport": self = .mediumTransport
        case "Droid control ship": self = .droidControlShip
        case "assault ship": self = .assultShip
        case "star destroyer": self = .stardestroyer
        case "starfighter": self = .starFighter
        case "corvette": self = .corvette
        case "cruiser": self = .cruiser
        default: return nil
        }
    }
}









