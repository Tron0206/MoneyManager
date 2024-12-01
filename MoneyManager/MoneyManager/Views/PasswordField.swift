//
//  PasswordField.swift
//  MoneyManager
//
//  Created by Zhasur Sidamatov on 01.12.2024.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField("Пароль", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.leading, 10)
            } else {
                SecureField("Пароль", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.leading, 10)
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
        }
        .font(.sfProDisplayRegular(size: 16))
        .frame(height: 50)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
}
