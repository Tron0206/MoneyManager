//
//  AuthorizationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI
struct AuthorizationView: View {
    @FocusState private var isFocused: Bool
    
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var error = false
    @State private var errorDescription = ""
    @State private var navigateToMain = false
    @State private var loading = false
    @EnvironmentObject var appViewMod: appViewModel
    @EnvironmentObject private var modelData: DataService
    let loginErrorMessages: [String: String] = [
        "The email address is badly formatted.": "Неверный формат электронной почты.",
        "The supplied auth credential is malformed or has expired.":"Неверный логин или пароль.",
        "There is no user record corresponding to this identifier. The user may have been deleted.": "Пользователь с таким адресом электронной почты не найден.",
        "The password is invalid or the user does not have a password.": "Неверный пароль.",
        "The user account has been disabled by an administrator.": "Учетная запись пользователя отключена.",
        "A network error (such as timeout, interrupted connection or unreachable host) has occurred.": "Ошибка сети. Проверьте подключение к интернету."
    ]
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Text("Авторизация")
                        .font(.sfProDisplayBold(size: 32))
                        .offset(y: -110)
                        .foregroundStyle(.white)
                    
                    VStack(spacing: 14) {
                        CustomTextField(placeHolder: "E-mail", text: $email)
                        PasswordField(password: $password)
                    }
                    .padding(.bottom, 50)
                    .focused($isFocused)
                    
                    VStack(spacing: 14) {
                        Button(action: {
                            loading = true
                            FirebaseAuthService.shared.logIn(email: email, password: password) { result in
                                switch result{
                                case .success(let userId):
                                        print("Вход успешен, userId: \(userId)")
                                        DataStore.shared.userId = userId
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
                                errorDescription = loginErrorMessages[authError.localizedDescription] ?? "\(authError.localizedDescription)"
                                print("Неудалось войти: \(errorDescription)")
                                error = true
                                loading = false
                                            }
                                    }
                        }, label: {
                            Text("Войти")
                                .frame(maxWidth: .infinity)
                                .frame(height: 43)
                                .background(Color(hex: "#3D5AED"))
                                .font(.sfProDisplayRegular(size: 24))
                                .foregroundColor(.white)
                                .clipShape(.capsule)
                                .padding(.horizontal)
                        })
                        
                        NavigationLink(destination: RegistrationView()) {
                            Text("Регистрация")
                                .frame(maxWidth: .infinity)
                                .frame(height: 43)
                                .background(Color(.white))
                                .font(.sfProDisplayRegular(size: 24))
                                .foregroundColor(.black)
                                .clipShape(.capsule)
                                .padding(.horizontal)
                        }
                    }
                    
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Image("background").resizable().ignoresSafeArea())
            }
            .onTapGesture {
                isFocused = false
            }
            .alert(isPresented: $error) {
                Alert(title: Text("Ошибка"),
                      message: Text(errorDescription),
                      dismissButton: .default(Text("OK"))
                )
            }
        }
    }
#Preview {
    AuthorizationView()
}
