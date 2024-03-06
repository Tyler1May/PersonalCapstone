//
//  SearchFilterView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/9/24.
//

import SwiftUI

struct SearchFilterView: View {
    
    @State var minYear = String()
    @State var maxYear = String()
    @Environment(\.dismiss) var dismiss
    @State var selectedSearch = "make"
    let searchOptions = ["Make", "Model"]
    @State var selectedSort = "newest"
    let sortOptions = ["Newest", "Oldest"]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                Text("Filter Search")
                    .foregroundStyle(Color(AppTheme.text))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 150)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            Form {
                Section("Search By:") {
                    Picker("", selection: $selectedSearch) {
                        ForEach(searchOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .listRowBackground(Color(.gray.opacity(0.2)))
                    
                }
                .foregroundStyle(Color(AppTheme.text))
                .font(.custom("standard", size: 20))
                
                Section("Sort By:") {
                    Picker("", selection: $selectedSort) {
                        ForEach(sortOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .listRowBackground(Color(.gray.opacity(0.2)))
                    
                }
                .foregroundStyle(Color(AppTheme.text))
                .font(.custom("standard", size: 20))
                
                Section("Filter Years:") {
                    TextField("From", text: $minYear)
                        .keyboardType(.numberPad)
                    TextField("To", text: $maxYear)
                        .keyboardType(.numberPad)
                }
                .listRowBackground(Color(.gray.opacity(0.2)))
                .foregroundStyle(Color(AppTheme.text))
                .font(.custom("standard", size: 20))
                
            }
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            NavigationLink(destination: SearchView(minYear: minYear, maxYear: maxYear, selectedSearch: selectedSearch.lowercased(), selectedSort: selectedSort)) {
                Button {
                    dismiss()
                } label: {
                    Text("Apply Filters")
                        .foregroundStyle(Color(AppTheme.text))
                }
                .padding()
                .frame(width: 250, height: 50)
                .background(Color(AppTheme.primary))
                .clipShape(RoundedShape(corners: [.allCorners]))
                .padding()
                
                Spacer()
            }
            .padding(.leading, 60)
            .padding(.bottom)
        }
        .ignoresSafeArea()
    }
}

    

#Preview {
    SearchFilterView()
}
