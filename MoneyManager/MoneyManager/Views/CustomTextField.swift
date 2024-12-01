//
//  CustomTextField.swift
//  MoneyManager
//
//  Created by Zhasur Sidamatov on 01.12.2024.
//

import SwiftUI

struct CustomTextField: View {
    let placeHolder: String
    @Binding var text: String
    var body: some View {
        TextField(placeHolder, text: $text)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.leading, 10)
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
