//
//  AuthorizationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI

//class AuthorizationViewModel: ObservableObject {
//    enum ValidateError: Error {
//        case emailEmpty
//        case emailIncorrectFormat
//        case emailIncorrectDomen
//        case emailHasWhitespace
//        case passwordEmpty
//        
//        var errorDescription: String {
//            switch self {
//            case .emailEmpty:
//                return "Email обязателен"
//            case .emailIncorrectFormat:
//                return "Неверный формат email"
//            case .emailIncorrectDomen:
//                return "Неверный формат домена (две точки подряд)"
//            case .emailHasWhitespace:
//                return "Email не может содержать пробелы"
//            case .passwordEmpty:
//                return "Пустой пароль"
//            }
//        }
//    }
    
//    @Published var email = ""
//    @Published var password = ""
//    @Published var passwordTextFieldSecure = false
//    @Published var hasError = false
//    @Published var errorText = ""
    
    
//    func validateUserData() {
//        do {
//            try validateEmail(email)
//            if email.isEmpty {
//                throw ValidateError.passwordEmpty
//            }
//        }
//        catch let error {
//            hasError = true
//            guard let error = error as? ValidateError else {
//                errorText = "Неизвестная ошибка"
//                return
//            }
//            errorText = error.errorDescription
//        }
//    }
//    
//    func logIn() {
//        FirebaseAuthService.shared.logIn(email: email, password: password) { result in
//            switch result {
//            case .success(let id):
//                print(id)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    private func validateEmail(_ email: String) throws {
//        if email.isEmpty {
//            throw ValidateError.emailEmpty
//        }
//
//        let emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//
//        if !emailTest.evaluate(with: email) {
//            throw ValidateError.emailIncorrectFormat
//        }
//
//        if email.contains("..") {
//            throw ValidateError.emailIncorrectDomen
//        }
//
//        if email.contains(" ") {
//            throw ValidateError.emailHasWhitespace
//        }
//    }
//}

struct AuthorizationView: View {
    
//    @ObservedObject var viewModel = AuthorizationViewModel()
    
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var error = false
    @State private var errorDescription = ""
    @State private var navigateToMain = false
    @State private var loading = false
    @EnvironmentObject var appViewMod: appViewModel
    @EnvironmentObject private var modelData: ModelData
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
                            case .success(let authResult):
                                print("Вход успешен, userId: \(authResult)")
                                navigateToMain = true
                                UserDefaults.standard.set(true, forKey: "isLogin")
                                appViewMod.isLogin = true
                                loading = false
                                
                                
                                
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
                    destination: MainView(modelData: _modelData),
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
