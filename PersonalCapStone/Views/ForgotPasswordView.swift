//
//  ForgotPasswordView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = String()
    @State private var isShowingAlert = false
    @EnvironmentObject var authController: AuthController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                Spacer()
                }
                Text("Forgot your password?")
                    .foregroundStyle(Color(AppTheme.buttonText))
                    .font(.largeTitle)
                Text("Enter your email")
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
            }
            .padding()
            
            Button {
                authController.resetPassword(email: email)
                isShowingAlert = true
                email = ""
            } label: {
                Text("Reset")
                    .foregroundStyle(Color(AppTheme.buttonText))
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Password Reset Sent"), message: Text("Check email to reset password"), dismissButton: .default(Text("OK")))
            }
            .frame(width: 350, height: 50)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.allCorners]))
            .padding()
            
            Button {
                dismiss()
            } label: {
                Text("Back")
                    .foregroundStyle(Color(AppTheme.buttonText))
            }
            .frame(width: 350, height: 50)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.allCorners]))
            Spacer()
            
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    ForgotPasswordView()
}
