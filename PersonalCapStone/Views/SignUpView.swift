//
//  SignUpView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/6/24.
//

import SwiftUI

struct SignUpView: View {
    @State var email = String()
    @State var password = String()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                Spacer()
                }
                Text("Lets get started,")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
                Text("Create Your Account")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
            }
            .padding()
            .frame(height: 260)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            VStack {
                CustomTextField(imageName: "envelope", placeHolder: "Email", text: $email)
                    .padding()
                    .submitLabel(.return)
                    .autocorrectionDisabled()
                    .onSubmit {
                        hideKeyboard()
                    }
                CustomTextField(imageName: "lock", placeHolder: "Password", text: $password)
                    .padding()
                    .submitLabel(.return)
                    .autocorrectionDisabled()
                    .onSubmit {
                        hideKeyboard()
                    }
            }
            .padding()
            
            Button(action: registerUser) {
                Text("Create Account")
                    .foregroundStyle(Color(AppTheme.buttonText))
            }
            .frame(width: 350, height: 50)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.allCorners]))
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Already have an account? Login")
                    .padding()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    func registerUser() {
        authController.register(email: email, password: password) { success, str in
            if success {
                print("Resgistration successful")
            } else {
                print("Registration failed with error: \(str)")
            }
        }
        dismiss()

    }
}

#Preview {
    SignUpView()
}
