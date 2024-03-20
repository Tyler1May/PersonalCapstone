//
//  Network Layer.swift
//  PersonalCapStone
//
//  Created by Tyler May on 3/5/24.
//

import Foundation
import SwiftUI

struct ApiCar: Codable {
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
}


