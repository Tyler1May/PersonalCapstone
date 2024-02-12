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
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                Spacer()
                }
                Text("Lets get started,")
                    .foregroundStyle(Color(AppTheme.text))
                    .font(.largeTitle)
                Text("Create Your Account")
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
                CustomTextField(imageName: "lock", placeHolder: "Password", text: $password)
                    .padding()
            }
            .padding()
            
            Button {
                
            } label: {
                Text("Create Account")
                    .foregroundStyle(Color(AppTheme.text))
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
}

#Preview {
    SignUpView()
}
