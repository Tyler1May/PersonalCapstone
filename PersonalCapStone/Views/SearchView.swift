//
//  SearchView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct SearchView: View {
    
    let dummyCars = [
        Car(city_mpg: 25, class: "SUV", combination_mpg: 22, cylinders: 6, displacement: 3.0, drive: "AWD", fuel_type: "Gasoline", highway_mpg: 30, make: "Toyota", model: "Rav4", transmission: "a", year: 2022),

        Car(city_mpg: 30, class: "Sedan", combination_mpg: 28, cylinders: 4, displacement: 2.0, drive: "FWD", fuel_type: "Gasoline", highway_mpg: 35, make: "Honda", model: "Civic", transmission: "m", year: 2023),

        Car(city_mpg: 20, class: "Truck", combination_mpg: 18, cylinders: 8, displacement: 5.0, drive: "4WD", fuel_type: "Diesel", highway_mpg: 25, make: "Ford", model: "F-150", transmission: "a", year: 2021),
        
        Car(city_mpg: 25, class: "SUV", combination_mpg: 22, cylinders: 6, displacement: 3.0, drive: "AWD", fuel_type: "Gasoline", highway_mpg: 30, make: "Toyota", model: "Rav4", transmission: "a", year: 2022),

        Car(city_mpg: 30, class: "Sedan", combination_mpg: 28, cylinders: 4, displacement: 2.0, drive: "FWD", fuel_type: "Gasoline", highway_mpg: 35, make: "Honda", model: "Civic", transmission: "m", year: 2023),

        Car(city_mpg: 20, class: "Truck", combination_mpg: 18, cylinders: 8, displacement: 5.0, drive: "4WD", fuel_type: "Diesel", highway_mpg: 25, make: "Ford", model: "F-150", transmission: "a", year: 2021)
    ]
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search", text: $searchText)
                    Image(systemName: "magnifyingglass")
                }
                .padding()
                .frame(width: 400, height: 50)
                .textFieldStyle(.roundedBorder)
                .background(Color(AppTheme.primary))
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("\(Image(systemName: "line.3.horizontal.decrease.circle.fill"))Filter")
                            .foregroundStyle(Color(AppTheme.text))
                    }
                    .foregroundStyle(.white)
                    .frame(width: 100, height: 25)
                    .background(.white)
                    .clipShape(RoundedShape(corners: [.allCorners]))
                    .padding(.trailing)
                    .padding(.bottom)
                }
                .background(Color(AppTheme.primary))
                .clipShape(RoundedShape(corners: [.bottomLeft]))
                
                List(dummyCars, id: \.make) { car in
                    NavigationLink(destination: CarDetailView(car: car)) {
                        HStack {
                            Text(Image(systemName: "car.fill"))
                                .padding()
                            VStack(alignment: .leading) {
                                Text("Vehicle: \(car.make) \(car.model)")
                                
                                Text("Year: \(String(car.year))")
                            }
                            Spacer()
                            Text(Image(systemName: "star"))
                                .font(.title)
                            
                        }
                        
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
                }
                .listRowSpacing(5)
                .scrollContentBackground(.hidden)
            }
        }
    }
}
    
    
#Preview {
    SearchView()
}
