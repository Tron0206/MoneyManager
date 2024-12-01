//
//  AuthorizationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI

struct AuthorizationView: View {
    
    @State private var email = ""
    @State private var pass = ""
    @State private var isSecure: Bool = true
    @State private var isError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Авторизация")
                    .fontWeight(.bold)
                    .font(.custom("SF Pro Text", size: 32))
                    .offset(y: -110)
                
                VStack(spacing: 14) {
                    CustomTextField(placeHolder: "E-mail", text: $email)
                    PasswordField(password: $pass)
                }.padding(.bottom, 50)
                
                VStack(spacing: 14) {
                    Button(action: {
                        if !isError {
                            
                        } else {
                            isError = false
                        }
                    }, label: {
                        Text("Войти")
                            .frame(maxWidth: .infinity)
                            .frame(height: 43)
                            .background(Color(hex: "#3D5AED"))
                            .font(.sfProDisplayRegular(size: 24))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding(.horizontal)
                    })
                    
                    NavigationLink(destination: RegistrationView()) {
                        Text("Регистрация")
                            .frame(maxWidth: .infinity)
                            .frame(height: 43)
                            .background(Color(.white))
                            .font(.sfProDisplayRegular(size: 24))
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(hex: "#3D5AED"), lineWidth: 1))
                            .padding(.horizontal)
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("background").resizable().ignoresSafeArea())
                .blur(radius: isError ? 2 : 0)
        }
        
        .alert(isPresented: $isError) {
            Alert(title: Text("Неверные данные"),
                  message: Text("Проверьте корректность введенной информации"),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    AuthorizationView()
}
