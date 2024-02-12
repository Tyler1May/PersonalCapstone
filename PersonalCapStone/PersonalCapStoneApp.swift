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
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
