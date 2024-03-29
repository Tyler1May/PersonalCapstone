//
//  CarDetailView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/9/24.
//

import SwiftUI

struct CarDetailView: View {
    
    var car: Car?
    @State var showDetail = false
    @State var showImg = false
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var carsController: CarsController
    
    var carDetails: [String] {
        [
            "Make: \(car?.make.capitalized ?? "")", "Model: \(car?.model.capitalized ?? "") ", "Year: \(car?.year ?? 0)", "Fuel Type: \(car?.fuel_type ?? "")", "Drive: \(car?.drive ?? "")", "Transmission: \(car?.transmissionDescription ?? "")", "Cylinders: \(car?.cylinders ?? 0)", "Displacement: \(car?.displacement ?? 0)",
            "Highway Mpg: \(car?.highway_mpg ?? 0)", "City Mpg: \(car?.city_mpg ?? 0)", "Combination Mpg: \(car?.combination_mpg ?? 0)"
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                }
                Text("\(car?.make.capitalized ?? "") \(car?.model.capitalized ?? "")")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 160)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomLeft]))
            
            VStack() {
                AsyncImage(url: URL(string: car?.img ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 375, height: 225)
                                .clipShape(LessRoundedShape(corners: [.allCorners]))
                                .padding()
                                .scaleEffect(showImg ? 1 : 0.25)
                                .onAppear {
                                    withAnimation(.easeIn.speed(1)) {
                                        showImg = true
                                    }
                                }
                    case .empty:
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 375, height: 225)
                            .clipShape(LessRoundedShape(corners: [.allCorners]))
                            .padding()
                            .foregroundStyle(.clear)
                    case .failure(_):
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 375, height: 225)
                            .clipShape(LessRoundedShape(corners: [.allCorners]))
                            .padding()

                    @unknown default:
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 375, height: 225)
                            .clipShape(LessRoundedShape(corners: [.allCorners]))
                            .padding()

                    }
                }
                
                if showDetail {
                        VStack() {
                            ForEach(carDetails, id: \.self) { detail in
                                Text(detail)
                            }
                        }
                        .foregroundStyle(Color(AppTheme.text))
                }
                
                Spacer()
                
                Button {
                    toggleFavCar()
                } label: {
                    HStack {
                        Text("Favorite")
                            .foregroundStyle(Color(AppTheme.buttonText))
                            .padding(.trailing, 100)
                            .font(.title)
                        if !(car.map { carsController.favoriteCars.contains($0) } ?? false) {
                            Image(systemName: "star")
                                .foregroundStyle(Color(AppTheme.buttonText))
                                .font(.title)
                                .contentTransition(.symbolEffect(.replace))
                        } else {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .font(.title)
                                .contentTransition(.symbolEffect(.replace))
                        }
                    }
                }
                .padding()
                .frame(width: 350, height: 50)
                .background(Color(AppTheme.primary))
                .clipShape(RoundedShape(corners: [.allCorners]))
                .padding()
                
                Button {
                    dismiss()
                } label: {
                        Text("Back")
                            .foregroundStyle(Color(AppTheme.buttonText))
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
        .onAppear {
            withAnimation(.smooth.delay(0.2)) {
                self.showDetail.toggle()
            }
        }
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
    
    func toggleFavCar() {
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
    }
    
}



#Preview {
    CarDetailView(car: Car(city_mpg: 10, carClass: "fast", combination_mpg: 10, cylinders: 10, displacement: 10.0, drive: "fwd", fuel_type: "gas", highway_mpg: 10, make: "big", model: "car", transmission: "a", year: 1021))
        .environmentObject(CarsController())
}
