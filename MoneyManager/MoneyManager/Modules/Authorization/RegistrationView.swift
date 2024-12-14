//
//  RegistrationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {

    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var pass1 = ""
    @State private var pass2 = ""
    @State private var error = false
    @State private var errorDescription = ""
        @State private var navigateToMain = false
        @State private var loading = false
        @EnvironmentObject private var modelData: DataService
        @EnvironmentObject var appViewMod: appViewModel

        let errorMessages: [String: String] = [
            "The email address is badly formatted.": "Неверный формат электронной почты.",
            "The password must be 6 characters long or more.": "Пароль должен содержать не менее 6 символов.",
            "The email address is already in use by another account.": "Этот адрес электронной почты уже используется."
        ]

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
                    loading = true
                    if pass1==pass2{
                    FirebaseAuthService.shared.register(email: email, password: pass1){result in
                        
                        switch result{
                            case .success(let authResult):
                                print("Регистрация успешна! Пользователь: \(authResult.user.email ?? "нет e-mail")")
                            
                                DataStore.shared.userId = authResult.user.uid
                            
                                modelData.loadData()
                            
                            DispatchQueue.global().async {
                                while !modelData.isDataLoaded {
                                    usleep(100_000)
                                }
                                DispatchQueue.main.async {
                                    navigateToMain = true
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    appViewMod.isLogin = true
                                    loading = false
                                }
                            }
                            case .failure(let authError):
                                errorDescription = errorMessages[authError.localizedDescription] ?? "Неизвестная ошибка, попробуйте еще раз"
                                print("Ошибка регистрации: \(errorDescription)")
                                error = true
                                loading = false}}}
                    else{
                        error = true
                        errorDescription = "Пароли не совпадают"
                        loading = false
                    }
                },
                label: {
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
                            Alert(title: Text("Ошибочка вышла"), message: Text("\(errorDescription)"), dismissButton: .default(Text("OK")))
                        }
                })

            }
            NavigationLink(
                            destination: MainView(),
                            isActive: $navigateToMain)
                        {EmptyView()}
                        if loading {
                            ZStack {
                                Color.black.opacity(0.4)
                                    .ignoresSafeArea()

                                VStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .scaleEffect(1.5)
                                    Text("Загрузка...")
                                        .foregroundColor(.white)
                                        .padding(.top, 10)
                                }
                                .padding(20)
                                .background(Color.gray.opacity(0.8))
                                .cornerRadius(12)
                                .shadow(radius: 10)
                            }

                        }
                    }
                    .background(Image("background").resizable().ignoresSafeArea())
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
