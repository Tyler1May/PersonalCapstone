//
//  ProfileView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/15/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authController: AuthController
    @EnvironmentObject var carsController: CarsController
    @State private var isShowingAlert = false
    @State private var isPasswordVisible = false
    
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                }
                Text("Account")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 150)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomLeft]))
            
            Form {
                Section("Email :") {
                    Text("\(authController.email)")
                        .foregroundStyle(Color(AppTheme.text))
                }
                .listRowBackground(Color.clear)
                .listSectionSpacing(50)
                
                Section("") {
                    Button {
                        isShowingAlert = true
                    } label: {
                        Text("Reset Password")
                            .foregroundStyle(Color(AppTheme.buttonText))
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Are You Sure You Want To Reset Password"), message: Text("Reseting Password Will Sign You Out. Check Your email to reset password."), primaryButton: .destructive(Text("Reset"), action: resetPassword), secondaryButton: .default(Text("Cancel")))
                    }
                    .frame(width: 300, height: 50)
                    .background(Color(AppTheme.primary))
                    .clipShape(RoundedShape(corners: [.allCorners]))

                }
                .listRowBackground(Color.clear)
                
            }
            .font(.title2)
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            
            Button {
                carsController.cars = []
                carsController.favoriteCars = []
                API.shared.imageDictionary = [:]
                authController.signOut()
            } label: {
                Text("Sign Out")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.title2)
            }
            .frame(width: 300, height: 50)
            .background(.red)
            .clipShape(RoundedShape(corners: [.allCorners]))
            .padding(.bottom, 100)
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func resetPassword() {
        authController.resetPassword(email: authController.email)
        authController.signOut()
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthController())
        .environmentObject(CarsController())
}
