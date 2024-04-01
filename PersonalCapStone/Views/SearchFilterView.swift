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
    let searchOptions = ["Make", "Model"]
    let years = Array(1990...2023)
    @State var isFilterShowing: Bool = Bool()
        
    var body: some View {
        VStack() {
            Form {
                Section("Search By:") {
                    Picker("", selection: $carsController.selectedSearch) {
                        ForEach(searchOptions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .listRowBackground(Color(.white))
                    
                    Picker("", selection: $carsController.year) {
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
        .ignoresSafeArea()
        .background(Color(AppTheme.primary))
    }
}

    

#Preview {
    SearchFilterView()
        .environmentObject(CarsController())
}

