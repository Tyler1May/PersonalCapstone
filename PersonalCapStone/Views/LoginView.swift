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
    @State private var isPasswordVisible = false
    @EnvironmentObject var authController: AuthController
    @State private var errorText: String?
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                Spacer()
                }
                Text("Welcome Back,")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
                Text("Lets get searching")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 260)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomLeft]))
            
            VStack {
                CustomTextField(imageName: "envelope", placeHolder: "Email", text: $email)
                    .padding()
                    .onChange(of: email) {
                        self.errorText = nil
                    }
                HStack {
                    if isPasswordVisible {
                        CustomTextField(imageName: "lock", placeHolder: "Password", text: $password)
                            .padding()
                            .onChange(of: password) {
                                self.errorText = nil
                            }
                    } else {
                        CustomSecureTextField(imageName: "lock", placeHolder: "Password", text: $password)
                            .padding()
                            .onChange(of: password) {
                                self.errorText = nil
                            }
                    }
                }.overlay(alignment: .trailing) {
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundStyle(Color(AppTheme.text))
                        .padding()
                        .onTapGesture {
                            isPasswordVisible.toggle()
                        }
                }
                if let errorText {
                    Text(errorText)
                        .foregroundStyle(Color.red)
                }
            }
            
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
                        print("loging failed with error: \(str)")
                        withAnimation(.bouncy) {
                            self.errorText = "Incorrect Email or Password"
                        }
                    }
                }
            } label: {
                Text("Login")
                    .foregroundStyle(Color(AppTheme.buttonText))
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
