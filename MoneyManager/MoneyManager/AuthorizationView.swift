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
                    
                    TextField("E-mail", text: $email)
                        .padding()
                        .background(Color("Color_#E6E6E6"))
                        .cornerRadius(5)
                        .padding()
                        .autocapitalization(.none)
                    
                    ZStack(alignment: .trailing) {
                        Group {
                            if isSecure {
                                TextField("Пароль", text: $pass)
                            } else {
                                SecureField("Пароль", text: $pass)
                            }
                        }.padding(.trailing, 32)
                        
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            if isSecure {
                                Image("eye")
                            } else {
                                Image("eye_crossed_out")
                            }
                        }
                        .padding(10)
                        
                    }.background(Color("Color_#E6E6E6"))
                        .cornerRadius(5)
                        .padding()
                    
                    Button(action: {
                        if !isError {
                            // проверка данных и, если не норм, то:
                            
                        } else {
                            isError = false
                        }
                    }, label: {
                        Text("Войти")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Color_#3D5AED"))
                            .font(.custom("SF Pro Text", size: 24))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()
                            .alert(isPresented: $isError) {
                                Alert(title: Text("Неверные данные"), message: Text("Проверьте корректность введенной информации"), dismissButton: .default(Text("OK")))
                                }
                    })
                    
                    NavigationLink(destination: registrationView()) {
                        Text("Регистрация")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.white))
                            .font(.custom("SF Pro Text", size: 24))
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("Color_#3D5AED"), lineWidth: 1))
                            
                            .padding()
                    }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("background").resizable().ignoresSafeArea())
            .blur(radius: isError ? 2 : 0)
        }
    }
}

#Preview {
    AuthorizationView()
}
