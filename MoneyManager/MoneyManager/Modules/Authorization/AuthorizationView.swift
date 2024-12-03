//
//  AuthorizationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
    enum EmailValidateError: Error {
        case empty
        case incorrectFormat
        case incorrectDomen
        case hasWhitespace
    }
    
    var email = ""
    var password = ""
    var passwordTextFieldSecure = false
    var hasError = false
    
    
//    func validateUserData() {
//        try {
//            
//        }
//        catch {
//            
//        }
//    }
    
//    private func validateEmail(_ email: String) throws {
//        if email.isEmpty {
//            throw "Email обязателен"
//        }
//
//        // Регулярное выражение для базовой валидации email
//        let emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//
//        // Проверка на неправильный формат
//        if !emailTest.evaluate(with: email) {
//            throw "Email обязателен"
//        }
//
//        // Дополнительная проверка для домена, например, двойных точек
//        if email.contains("..") {
//            throw "Email обязателен"
//        }
//
//        // Проверка на символы пробела
//        if email.contains(" ") {
//            throw "Email обязателен"
//        }
//    }
}

struct AuthorizationView: View {
    
    @ObservedObject var viewModel = AuthorizationViewModel()
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Авторизация")
                    .font(.sfProDisplayBold(size: 32))
                    .offset(y: -110)
                    .foregroundStyle(.white)
                
                VStack(spacing: 14) {
                    CustomTextField(placeHolder: "E-mail", text: $viewModel.email)
                    PasswordField(password: $viewModel.password)
                }
                .padding(.bottom, 50)
                .focused($isFocused)
                
                VStack(spacing: 14) {
                    Button(action: {
                        if !viewModel.hasError {
                            print(viewModel.email)
                            print(viewModel.password)
                        } else {
                            viewModel.hasError = false
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
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("background").resizable().ignoresSafeArea())
                .blur(radius: viewModel.hasError ? 2 : 0)
        }
        .onTapGesture {
            isFocused = false
        }
        .alert(isPresented: $viewModel.hasError) {
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
