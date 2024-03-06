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
    var minYear = String()
    var maxYear = String()
    var selectedSearch = "make"
    var selectedSort = String() // newest to oldest
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                    HStack {
                        TextField("Search", text: $searchText)
                            .padding(.trailing)
                        Button {
                            searchCars(param: selectedSearch, searchText: searchText)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color(AppTheme.text))
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
                            SearchFilterView()
                                .toolbar(.hidden)
                        } label: {
                            Text("\(Image(systemName: "line.3.horizontal.decrease.circle.fill"))  Filter")
                                .foregroundStyle(Color(AppTheme.text))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 25)
                        .background(.white)
                        .clipShape(RoundedShape(corners: [.allCorners]))
                        .padding(.trailing, 5)
                        .padding(.bottom)
                    }
                .background(Color(AppTheme.primary))
                .clipShape(RoundedShape(corners: [.bottomLeft]))
                
                
                
                List(carsController.cars) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            HStack {
                                Text(Image(systemName: "car.fill"))
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text("Vehicle: \(car.make) \(car.model)")
                                    Text("Year: \(String(car.year))")
                                }
                                Spacer()
                                Image(systemName: carsController.favoriteCars.contains(car) ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundStyle(carsController.favoriteCars.contains(car) ? .yellow : Color(AppTheme.text))
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
                                            getFavoriteCar()
                                        }
                                    }
                            }
                        }
                        .listRowBackground(Color.gray.opacity(0.2))
                }
                .listRowSpacing(5)
                .scrollContentBackground(.hidden)
                
                Spacer()
            }
        }
    }
    
    func searchCars(param: String, searchText: String){
        Task {
            do {
                let cars = try await API.getCars(param: param, searchText: searchText)
                DispatchQueue.main.async {
                    self.carsController.cars = cars
                }
            } catch {
                print(error.localizedDescription)
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
    
}
    
    
#Preview {
    SearchView()
        .environmentObject(CarsController())
}
