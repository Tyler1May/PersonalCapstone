//
//  PersonalCapStoneApp.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/6/24.
//

import SwiftUI
import FirebaseCore

@main
struct PersonalCapStoneApp: App {
    
    @StateObject var authController = AuthController()
    @StateObject var carsController = CarsController()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
                .environmentObject(carsController)
        }
    }
}
