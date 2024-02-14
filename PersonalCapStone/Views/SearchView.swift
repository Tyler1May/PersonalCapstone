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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(.trailing)
                    Button {
                        
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
                
                List(carsController.dummyCars) { car in
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
                                    if carsController.favoriteCars.contains(where: { $0.id == car.id }) {
                                        carsController.favoriteCars.removeAll(where: { $0.id == car.id })
                                    } else {
                                        carsController.favoriteCars.append(car)
                                    }
                                }
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
        .environmentObject(CarsController())
}
