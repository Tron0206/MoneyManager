//
//  RegistrationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI


struct registrationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var pass1 = ""
    @State private var pass2 = ""
    @State private var error = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Text("Регистрация")
                    .fontWeight(.bold)
                    .font(.custom("SF Pro Text", size: 32))
            }.position(x: 200, y: 77)
            
            VStack {
                TextField("E-mail", text: $email)
                    .padding()
                    .background(Color("Color_#E6E6E6"))
                    .cornerRadius(5)
                    .padding()
                    .autocapitalization(.none)
                
                TextField("Пароль", text: $pass1)
                    .padding()
                    .background(Color("Color_#E6E6E6"))
                    .cornerRadius(5)
                    .padding()
                    .autocapitalization(.none)
                
                TextField("Подтверждение пароля", text: $pass2)
                    .padding()
                    .background(Color("Color_#E6E6E6"))
                    .cornerRadius(5)
                    .padding()
                    .autocapitalization(.none)
                
                Button(action: {
                    if pass1 == pass2 {
                        print("регистрация успешна")
                        error = false
                    } else {
                        print("Проверте корр данных")
                        error = true
                    }
                }, label: {
                    Text("Зарегистрироваться")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Color_#3D5AED"))
                        .font(.custom("SF Pro Text", size: 24))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding()
                        .alert(isPresented: $error) {
                            Alert(title: Text("Неверные данные"), message: Text("Проверьте корректность введенной информации"), dismissButton: .default(Text("OK")))
                        }
                })

            }
            
            
        }.background(Image("background").resizable().ignoresSafeArea())
            .blur(radius: error ? 2 : 0)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image("icon")
                                .frame(width: 18, height: 24)
                            Text("Назад")
                                .foregroundColor(.black)
                                .font(.custom("SF Pro Text", size: 17))
                        }
                    }
                }
            }
    }
}


#Preview {
    registrationView()
}
