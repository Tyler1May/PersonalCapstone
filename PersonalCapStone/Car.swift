//
//  Car.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import Foundation
import SwiftUI

struct Car: Codable {
    var city_mpg: Int
    var `class`: String
    var combination_mpg: Int
    var cylinders: Int
    var displacement: Double
    var drive: String
    var fuel_type: String
    var highway_mpg: Int
    var make: String
    var model: String
    var transmission: String
    var year: Int
    
    var transmissionDescription: String {
        switch transmission {
        case "a": return "automatic"
        case "m": return "manual"
        default: return "n/a"
        }
    }
}




