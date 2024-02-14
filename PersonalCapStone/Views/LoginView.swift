//
//  LoginView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/6/24.
//

import SwiftUI

struct LoginView: View {
    @State var email = String()
    @State var password = String()
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                Spacer()
                }
                Text("Welcome Back,")
                    .foregroundStyle(Color(AppTheme.text))
                    .font(.largeTitle)
                Text("Lets get searching")
                    .foregroundStyle(Color(AppTheme.text))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 260)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomLeft]))
            
            VStack {
                CustomTextField(imageName: "envelope", placeHolder: "Email", text: $email)
                    .padding()
                CustomSecureTextField(imageName: "lock", placeHolder: "Password", text: $password)
                    .padding()
            }
            .padding()
            
            HStack {
                Spacer()
                NavigationLink {
                    ForgotPasswordView()
                        .toolbar(.hidden)
                } label: {
                    Text("Forgot Password?")
                        .foregroundStyle(.blue)
                }
                .padding()
            }
            
            Button {
                authController.login(email: email, password: password) { success, str in
                    if !success {
                        #warning("handle Errors")
                    }
                }
            } label: {
                Text("Login")
                    .foregroundStyle(Color(AppTheme.text))
            }
            .frame(width: 350, height: 50)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.allCorners]))
            Spacer()
            
            NavigationLink {
                SignUpView()
                    .toolbar(.hidden)
            } label: {
                Text("Don't have an account? Sign Up")
                    .padding()
                    .foregroundStyle(.blue)
            }
            .padding()
        }
        .ignoresSafeArea()
        .toolbar(.hidden)
    }
}

#Preview {
    LoginView()
}
