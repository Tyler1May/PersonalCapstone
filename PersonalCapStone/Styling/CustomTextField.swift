//
//  CustomTextField.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/6/24.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: imageName)
                TextField(placeHolder, text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Divider()
        }
    }
}

struct CustomSecureTextField: View {
    let imageName: String
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: imageName)
                SecureField(placeHolder, text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Divider()
        }
    }
}

#Preview {
    CustomTextField(imageName: "envelope", placeHolder: "Email", text: .constant(""))
}
