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
                    .foregroundStyle(Color(AppTheme.text))
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
                .listSectionSpacing(50)
                
                Section("Password :") {
                    HStack {
                        Text(isPasswordVisible ? "\(authController.password)" : "***********")
                        Spacer()
                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                            .foregroundStyle(Color(AppTheme.text))
                            .padding()
                            .onTapGesture {
                                isPasswordVisible.toggle()
                            }
                    }
                    Button {
                        isShowingAlert = true
                    } label: {
                        Text("Reset Password")
                            .foregroundStyle(Color(AppTheme.text))
                    }
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Are You Sure You Want To Reset Password"), message: Text("Reseting Password Will Sign You Out. Check Your email to reset password."), primaryButton: .destructive(Text("Reset"), action: resetPassword), secondaryButton: .default(Text("Cancel")))
                    }
                    .frame(width: 300, height: 50)
                    .background(Color(AppTheme.primary))
                    .clipShape(RoundedShape(corners: [.allCorners]))

                }
                
            }
            .font(.title2)
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            
            Button {
                authController.signOut()
                carsController.cars = []
                carsController.favoriteCars = []
                API.shared.imageDictionary = [:]
            } label: {
                Text("Sign Out")
                    .foregroundStyle(Color(AppTheme.text))
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
