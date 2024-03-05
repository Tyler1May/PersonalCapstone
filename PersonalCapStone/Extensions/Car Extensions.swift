//
//  Car Extensions.swift
//  PersonalCapStone
//
//  Created by Tyler May on 3/5/24.
//

import Foundation

extension ApiCar {
    func toCar() -> Car {
        return Car(city_mpg: self.city_mpg, carClass: self.class, combination_mpg: self.combination_mpg, cylinders: self.cylinders, displacement: self.displacement, drive: self.drive, fuel_type: self.fuel_type, highway_mpg: self.highway_mpg, make: self.make, model: self.model, transmission: self.transmission, year: self.year)
    }
}
