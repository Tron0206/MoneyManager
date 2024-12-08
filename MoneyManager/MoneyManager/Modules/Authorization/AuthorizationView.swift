//
//  AuthorizationView.swift
//  MoneyManager
//
//  Created by ksenia on 28.11.2024.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
    enum ValidateError: Error {
        case emailEmpty
        case emailIncorrectFormat
        case emailIncorrectDomen
        case emailHasWhitespace
        case passwordEmpty
        
        var errorDescription: String {
            switch self {
            case .emailEmpty:
                return "Email обязателен"
            case .emailIncorrectFormat:
                return "Неверный формат email"
            case .emailIncorrectDomen:
                return "Неверный формат домена (две точки подряд)"
            case .emailHasWhitespace:
                return "Email не может содержать пробелы"
            case .passwordEmpty:
                return "Пустой пароль"
            }
        }
    }
    
    @Published var email = ""
    @Published var password = ""
    @Published var passwordTextFieldSecure = false
    @Published var hasError = false
    @Published var errorText = ""
    
    
    func validateUserData() {
        do {
            try validateEmail(email)
            if email.isEmpty {
                throw ValidateError.passwordEmpty
            }
        }
        catch let error {
            hasError = true
            guard let error = error as? ValidateError else {
                errorText = "Неизвестная ошибка"
                return
            }
            errorText = error.errorDescription
        }
    }
    
    func logIn() {
        FirebaseAuthService.shared.logIn(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let id):
                    UserDefaults.standard.set(id, forKey: "userId")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func validateEmail(_ email: String) throws {
        if email.isEmpty {
            throw ValidateError.emailEmpty
        }

        let emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        if !emailTest.evaluate(with: email) {
            throw ValidateError.emailIncorrectFormat
        }

        if email.contains("..") {
            throw ValidateError.emailIncorrectDomen
        }

        if email.contains(" ") {
            throw ValidateError.emailHasWhitespace
        }
    }
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
                        viewModel.validateUserData()
                        viewModel.logIn()
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
        }
        .onTapGesture {
            isFocused = false
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Ошибка"),
                  message: Text(viewModel.errorText),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    AuthorizationView()
}
