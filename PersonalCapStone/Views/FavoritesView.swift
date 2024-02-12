//
//  FavoritesView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @State var favoreiteCars: [Car] = [Car(city_mpg: 30, class: "Sedan", combination_mpg: 28, cylinders: 4, displacement: 2.0, drive: "FWD", fuel_type: "Gasoline", highway_mpg: 35, make: "Honda", model: "Civic", transmission: "m", year: 2023)]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                    }
                    Text("Favorites")
                        .foregroundStyle(Color(AppTheme.text))
                        .font(.largeTitle)
                }
                .padding()
                .frame(height: 150)
                .background(Color(AppTheme.primary))
                .clipShape(RoundedShape(corners: [.bottomRight]))
                
                
                if favoreiteCars.isEmpty {
                    Spacer()
                    Text("No favorites yet")
                        .font(.largeTitle)
                        .opacity(0.2)
                    Spacer()
                } else {
                    List(favoreiteCars, id: \.make) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            HStack {
                                Text(Image(systemName: "car.fill"))
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text("Car: \(car.make) \(car.model)")
                                    
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
            .ignoresSafeArea()
        }
    }
}

#Preview {
    FavoritesView()
}
