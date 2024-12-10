//
//  ProfileScreenView.swift
//  MoneyManager
//
//  Created by ksenia on 10.12.2024.
//

import SwiftUI

struct ProfileScreenView: View {
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 36, height: 5)
                .foregroundColor(Color(hex: "3C3C43"))
                .padding(5)
            
            Text("Профиль")
                .font(.title)
                .fontWeight(.medium)
            
            Text("E-mail")  // TODO: add email
                .offset(x: -160)
                .padding()
                .foregroundColor(Color(hex: "929292"))
                .frame(maxWidth: .infinity)
                .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(hex: "6F98CB")),
                        alignment: .bottom
                ).padding()
            
            Spacer()
            
            Button {
                //
            } label: {
                Text("Выйти из профиля")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "D9D9D9"))
                    .font(.sfProDisplayRegular(size: 18))
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
}
