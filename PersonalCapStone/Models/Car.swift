//
//  Car.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Car: Codable, Equatable, Identifiable {
    @DocumentID var firestoreId: String?
    var id = UUID().uuidString
    var city_mpg: Int
    var carClass: String
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
    var img: String?
    
    var transmissionDescription: String {
        switch transmission {
        case "a": return "Automatic"
        case "m": return "Manual"
        default: return "n/a"
        }
    }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.city_mpg == rhs.city_mpg &&
                lhs.carClass == rhs.carClass &&
                lhs.combination_mpg == rhs.combination_mpg &&
                lhs.cylinders == rhs.cylinders &&
                lhs.displacement == rhs.displacement &&
                lhs.drive == rhs.drive &&
                lhs.fuel_type == rhs.fuel_type &&
                lhs.highway_mpg == rhs.highway_mpg &&
                lhs.make == rhs.make &&
                lhs.model == rhs.model &&
                lhs.transmission == rhs.transmission &&
                lhs.year == rhs.year &&
                lhs.img == rhs.img
    }
    
}
