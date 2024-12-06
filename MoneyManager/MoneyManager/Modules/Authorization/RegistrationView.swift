//
//  RegistrationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI


struct RegistrationView: View {

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
                    .foregroundStyle(.white)
            }.position(x: 200, y: 77)

            VStack(spacing: 36) {
                VStack(spacing: 14) {
                    CustomTextField(placeHolder: "E-mail", text: $email)
                    CustomTextField(placeHolder: "Пароль", text: $pass1)
                    CustomTextField(placeHolder: "Подтверждение пароля", text: $pass2)
                }
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
                        .frame(height: 43)
                        .background(Color(hex: "3D5AED"))
                        .font(.sfProDisplayRegular(size: 24))
                        .foregroundColor(.white)
                        .clipShape(.capsule)
                        .padding(.horizontal)
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
                            Image(systemName: "chevron.left")
                                .frame(width: 18, height: 24)
                                .tint(.black)
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
    RegistrationView()
}
