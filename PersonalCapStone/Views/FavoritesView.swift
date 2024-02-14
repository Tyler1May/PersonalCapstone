//
//  FavoritesView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var carsController: CarsController
    
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
                
                
                if carsController.favoriteCars.isEmpty {
                    Spacer()
                    Text("No favorites yet")
                        .font(.largeTitle)
                        .opacity(0.2)
                    Spacer()
                } else {
                    List(carsController.favoriteCars) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            HStack {
                                Text(Image(systemName: "car.fill"))
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text("Vehicle: \(car.make) \(car.model)")
                                    Text("Year: \(String(car.year))")
                                }
                                Spacer()
                                Image(systemName: carsController.favoriteCars.contains(where: { $0.id == car.id }) ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundStyle(carsController.favoriteCars.contains(where: { $0.id == car.id }) ? .yellow : Color(AppTheme.text))
                                    .onTapGesture {
                                        guard let favoriteI = carsController.favoriteCars.firstIndex(where: { $0.id == car.id }) else { return }
                                        carsController.favoriteCars.remove(at: favoriteI)
                                        
                                    }
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
        .environmentObject(CarsController())
}
