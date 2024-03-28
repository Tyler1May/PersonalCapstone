//
//  SearchView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var carsController: CarsController
    
    @State var searchText = ""
    @State var isLoading = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("",
                              text: $searchText,
                              prompt: Text("Search By \(carsController.selectedSearch.capitalized)")
                        .foregroundStyle(Color(AppTheme.text.opacity(0.5)))
                    )
                        .padding(.trailing)
                        .onSubmit() {
                            guard !searchText.isEmpty else {
                                return
                            }
                             isLoading = true
                            carsController.searchCars(param: carsController.selectedSearch, searchText: searchText, year: String(carsController.year)) {
                                isLoading = false
                            }
                        }
                    Button {
                        guard !searchText.isEmpty else {
                            return
                        }
                        isLoading = true
                        carsController.searchCars(param: carsController.selectedSearch, searchText: searchText, year: String(carsController.year)) {
                            isLoading = false
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color(AppTheme.button))
                            .font(.title)
                            .frame(width: 25)
                    }
                }
                .padding()
                .frame(width: 400, height: 50)
                .textFieldStyle(.roundedBorder)
                .background(Color(AppTheme.primary))
                HStack {
                    Spacer()
                    NavigationLink {
                        SearchFilterView(selectedSearch: carsController.selectedSearch)
                            .toolbar(.hidden)
                    } label: {
                        Text("\(Image(systemName: "slider.horizontal.3"))  Filter")
                            .foregroundStyle(Color(AppTheme.text))
                    }
                    .foregroundStyle(.white)
                    .frame(width: 100, height: 25)
                    .background(Color(AppTheme.button))
                    .clipShape(RoundedShape(corners: [.allCorners]))
                    .padding(.trailing, 5)
                    .padding(.bottom)
                }
                .background(Color(AppTheme.primary))
                
                if isLoading {
                    Spacer()
                    ProgressView()
                } else {
                    List(carsController.cars) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            HStack {
                                Text(Image(systemName: "car.side.fill"))
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text("Vehicle: \(car.make.localizedCapitalized) \(car.model.localizedCapitalized)")
                                    Text("Year: \(String(car.year))")
                                }
                                Spacer()
                                Image(systemName: carsController.favoriteCars.contains(car) ? "star.fill" : "star")
                                    .font(.title)
                                    .contentTransition(.symbolEffect(.replace))
                                    .foregroundStyle(.yellow)
                                    .onTapGesture {
                                        if carsController.favoriteCars.contains(car) {
                                            for i in carsController.favoriteCars {
                                                if i == car {
                                                    carsController.deleteFavoriteCars(firestoreID: i.firestoreId)
                                                }
                                            }
                                            carsController.favoriteCars.removeAll(where: { $0 == car })
                                        } else {
                                            carsController.addToFavorites(carData: car)
                                            carsController.getFavoriteCar()
                                        }
                                    }
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.2))
                    }
                    .listRowSpacing(5)
                    .scrollContentBackground(.hidden)
                }
                Spacer()
            }
        }
        
    }
    
}
    
    
#Preview {
    SearchView()
        .environmentObject(CarsController())
}
