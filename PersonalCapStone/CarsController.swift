//
//  CarsController.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/14/24.
//

import Foundation

class CarsController: ObservableObject {
    @Published var cars: [Car] = []
    @Published var favoriteCars: [Car] = []
    @Published var dummyCars = [
         Car(city_mpg: 25, class: "SUV", combination_mpg: 22, cylinders: 6, displacement: 3.0, drive: "AWD", fuel_type: "Gasoline", highway_mpg: 30, make: "Toyota", model: "Rav4", transmission: "a", year: 2022),

         Car(city_mpg: 30, class: "Sedan", combination_mpg: 28, cylinders: 4, displacement: 2.0, drive: "FWD", fuel_type: "Gasoline", highway_mpg: 35, make: "Honda", model: "Civic", transmission: "m", year: 2023),

         Car(city_mpg: 20, class: "Truck", combination_mpg: 18, cylinders: 8, displacement: 5.0, drive: "4WD", fuel_type: "Diesel", highway_mpg: 25, make: "Ford", model: "F-150", transmission: "a", year: 2021)
     ]
}
