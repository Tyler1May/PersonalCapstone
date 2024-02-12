//
//  ForgotPasswordView.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = String()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                HStack {
                Spacer()
                }
                Text("Forgot your password?")
                    .foregroundStyle(Color(AppTheme.text))
                    .font(.largeTitle)
                Text("Enter your email")
                    .foregroundStyle(Color(AppTheme.text))
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
                
            } label: {
                Text("Reset")
                    .foregroundStyle(Color(AppTheme.text))
            }
            .frame(width: 350, height: 50)
            .background(Color(AppTheme.primary))
            .clipShape(RoundedShape(corners: [.allCorners]))
            .padding()
            
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundStyle(Color(AppTheme.text))
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
