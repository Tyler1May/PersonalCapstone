//
//  ProfileView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/15/24.
//

import SwiftUI

struct ProfileView: View {
    
    var email = String()
    var password = String()
    @EnvironmentObject var authController: AuthController
    
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
                    Text("dummy1@fake. com")
                        .foregroundStyle(Color(AppTheme.text))
                }
                .listSectionSpacing(50)
                
                Section("Password :") {
                    Text("*************")
                    Button {
                        
                    } label: {
                        Text("Change Password")
                            .foregroundStyle(Color(AppTheme.text))
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
}

#Preview {
    ProfileView()
}
