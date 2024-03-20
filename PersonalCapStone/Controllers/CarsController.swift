//
//  CarsController.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/14/24.
//

import Foundation

class CarsController: ObservableObject {
    static let shared = CarsController()
    @Published var cars: [Car] = []
    @Published var favoriteCars: [Car] = []
    @Published var filteredCars: [Car] = []
    @Published var selectedSearch = "Make"
    @Published var selectedSort = "Newest To Oldest"
    @Published var minYear = 0
    @Published var maxYear = 9999
    
    @Published var dummyFavorites: [Car] = []
    @Published var dummyCars = [
         Car(city_mpg: 25, carClass: "SUV", combination_mpg: 22, cylinders: 6, displacement: 3.0, drive: "AWD", fuel_type: "Gasoline", highway_mpg: 30, make: "Toyota", model: "Rav4", transmission: "a", year: 2022),

         Car(city_mpg: 30, carClass: "Sedan", combination_mpg: 28, cylinders: 4, displacement: 2.0, drive: "FWD", fuel_type: "Gasoline", highway_mpg: 35, make: "Honda", model: "Civic", transmission: "m", year: 2023),

         Car(city_mpg: 20, carClass: "Truck", combination_mpg: 18, cylinders: 8, displacement: 5.0, drive: "4WD", fuel_type: "Diesel", highway_mpg: 25, make: "Ford", model: "F-150", transmission: "a", year: 2021)
     ]
    
    func filterCars() {
        switch selectedSort {
        case "Newest To Oldest":
            filteredCars = cars.filter { car in
                car.year >= minYear && car.year <= maxYear
            }.sorted(by: { $0.year > $1.year })
        case "Oldest To Newest":
            filteredCars = cars.filter { car in
                car.year >= minYear && car.year <= maxYear
            }.sorted(by: { $0.year < $1.year })
        default:
            filteredCars = cars.filter { car in
                car.year >= maxYear && car.year <= maxYear
            }
        }
        
    }
    
    func searchCars(param: String, searchText: String, completion: @escaping () -> Void) {
        Task {
            do {
                var cars = try await API.getCars(param: param, searchText: searchText)
                for (i, car) in cars.enumerated() {
                    cars[i].img = try await API.getCarImg(q: "\(car.year) \(car.make) \(car.model)")
            
                }
                
                
                
                DispatchQueue.main.async {
                    self.cars = cars
                    completion()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func getFavoriteCar() {
        Task {
            do{
                let cars = try await self.fetchFavoriteCars()
                DispatchQueue.main.async {
                    self.favoriteCars = cars
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    
    
    init() {
        Task{
            do {
                let cars = try await self.fetchFavoriteCars()
                DispatchQueue.main.async {
                    self.favoriteCars = cars
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    

}
