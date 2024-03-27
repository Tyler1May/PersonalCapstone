//
//  ContentView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var carsController: CarsController
    
    
    var body: some View {
        NavigationStack {
            if authController.userSession == nil {
                LoginView()
            } else {
                TabBarView()
                    .onAppear {
                        if API.shared.isLoaded == true {
                            return
                        } else {
                            API.shared.isLoaded = true
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthController())
}
