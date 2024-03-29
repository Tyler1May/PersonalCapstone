//
//  SearchFilterView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/9/24.
//

import SwiftUI

struct SearchFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var carsController: CarsController
    @State var selectedSearch = ""
    let searchOptions = ["Make", "Model"]
    @State var selectedYear = Int()
    let years = Array(1990...2023)
    @State var isFilterShowing: Bool = Bool()
    
    var body: some View {
        VStack() {
            Form {
                Section("Search By:") {
                    Picker("", selection: $selectedSearch) {
                        ForEach(searchOptions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .listRowBackground(Color(.white))
                    
                    Picker("", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text(String(year)).tag(year)
                        }
                    }
                    .listRowBackground(Color(.white))
                    
                }
                .foregroundStyle(Color(AppTheme.text))
                .font(.custom("standard", size: 20))
                
            }
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Button {
                carsController.selectedSearch = selectedSearch.lowercased()
                carsController.year = selectedYear
                withAnimation(.bouncy) {
                    carsController.isFilterShowing = false
                }
            } label: {
                Text("Apply Filters")
                    .foregroundStyle(Color(AppTheme.buttonText))
            }
            .padding()
            .frame(width: 250, height: 50)
            .background(.white)
            .clipShape(RoundedShape(corners: [.allCorners]))
            .padding()
            
        }
        .onAppear {
            selectedYear = carsController.year
            selectedSearch = carsController.selectedSearch.capitalized
        }
        .ignoresSafeArea()
        .background(Color(AppTheme.primary))
    }
}

    

#Preview {
    SearchFilterView()
        .environmentObject(CarsController())
}

