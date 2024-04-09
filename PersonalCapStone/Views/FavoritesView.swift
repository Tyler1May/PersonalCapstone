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
                        .foregroundStyle(Color(AppTheme.buttonText))
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
                                Text(Image(systemName: "car.side.fill"))
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text("Vehicle: \(car.make.localizedCapitalized) \(car.model.localizedCapitalized)")
                                    Text("Year: \(String(car.year))")
                                }
                                Spacer()
                                Image(systemName: carsController.favoriteCars.contains(where: {$0.id == car.id}) ? "star.fill" : "star")
                                    .font(.title)
                                    .contentTransition(.symbolEffect(.replace))
                                    .foregroundStyle(.yellow)
                                    .onTapGesture {
                                        guard let favoriteI = carsController.favoriteCars.firstIndex(of: car) else { return }
                                        carsController.deleteFavoriteCars(firestoreID: car.firestoreId)
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
        .onAppear {
            carsController.getFavoriteCar()
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(CarsController())
}
