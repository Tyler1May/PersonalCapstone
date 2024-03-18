//
//  CarDetailView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/9/24.
//

import SwiftUI

struct CarDetailView: View {
    
    var car: Car?
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var carsController: CarsController
    
    var carDetails: [String] {
        [
            "Make: \(car?.make.capitalized ?? "")", "Model: \(car?.model.capitalized ?? "") ", "Year: \(car?.year ?? 0)", "Fuel Type: \(car?.fuel_type ?? "")", "Drive: \(car?.drive ?? "")", "Transmission: \(car?.transmissionDescription ?? "")", "Cylinders: \(car?.cylinders ?? 0)",
            "Highway Mpg: \(car?.highway_mpg ?? 0)", "City Mpg: \(car?.city_mpg ?? 0)", "Combination Mpg: \(car?.combination_mpg ?? 0)"
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                }
                Text("Car Details")
                    .foregroundStyle(Color(AppTheme.text))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 150)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomLeft]))
            
            VStack() {
                Image("Test")
                    .padding()
                    .frame(width: 375, height: 225)
                    .clipShape(LessRoundedShape(corners: [.allCorners]))
                    .padding()
                
                Text("\(car?.make ?? "") \(car?.model ?? "")")
                    .font(.title)
                    .foregroundStyle(Color(AppTheme.text))
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading) {
                    ForEach(carDetails, id: \.self) { detail in
                        Text(detail)
                    }
                }
                .foregroundStyle(Color(AppTheme.text))
                .padding(.trailing, 175)
                
                Spacer()
                
                Button {
                    if let car = car {
                        if carsController.favoriteCars.contains(car) {
                            for i in carsController.favoriteCars {
                                if i == car {
                                    carsController.deleteFavoriteCars(firestoreID: i.firestoreId)
                                }
                            }
                            carsController.favoriteCars.removeAll(where: { $0 == car })
                        } else {
                            carsController.addToFavorites(carData: car)
                            getFavoriteCar()
                        }

                    }
                } label: {
                    HStack {
                        Text("Favorite")
                            .foregroundStyle(Color(AppTheme.text))
                            .padding(.trailing, 100)
                            .font(.title)
                        if !(car.map { carsController.favoriteCars.contains($0) } ?? false) {
                            Image(systemName: "star")
                                .foregroundStyle(Color(AppTheme.text))
                                .font(.title)
                        } else {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .font(.title)
                        }
                    }
                }
                .padding()
                .frame(width: 350, height: 50)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedShape(corners: [.allCorners]))
                .padding()
                
                Button {
                    dismiss()
                } label: {
                        Text("Back")
                            .foregroundStyle(Color(AppTheme.text))
                            .font(.largeTitle)
                         
                }
                .padding()
                .frame(width: 350, height: 50)
                .background(Color(AppTheme.primary))
                .clipShape(RoundedShape(corners: [.allCorners]))
            
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
    func getFavoriteCar() {
        Task {
            do{
                let cars = try await carsController.fetchFavoriteCars()
                DispatchQueue.main.async {
                    self.carsController.favoriteCars = cars
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}



#Preview {
    CarDetailView(car: Car(city_mpg: 10, carClass: "fast", combination_mpg: 10, cylinders: 10, displacement: 10.0, drive: "fwd", fuel_type: "gas", highway_mpg: 10, make: "big", model: "car", transmission: "a", year: 1021))
        .environmentObject(CarsController())
}
