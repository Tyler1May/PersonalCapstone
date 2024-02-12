//
//  TabBarView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            SearchView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(0)
            
            FavoritesView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "star")
                }.tag(1)
                
            }
    }
}

#Preview {
    TabBarView()
}
