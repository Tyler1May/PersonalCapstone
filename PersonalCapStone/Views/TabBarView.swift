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
                    Label("", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("", systemImage: "star")
                }
            
            ProfileView()
                .tabItem {
                    Label("", systemImage: "person")
                }
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(CarsController())
}
