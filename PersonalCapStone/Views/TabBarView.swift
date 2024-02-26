//
//  TabBarView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(CarsController())
}
