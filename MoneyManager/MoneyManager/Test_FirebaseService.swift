//
//  Test_FirebaseService.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 23.11.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseServiceTester {
    let firebaseService = FirebaseService()

    func testRegister() {
        firebaseService.register(email: "test@example.com", password: "TestPassword123") { result in
            switch result {
            case .success(let authResult):
                print("Регистрация успешна: \(authResult.user.email ?? "нет email")")
            case .failure(let error):
                print("Ошибка при регистрации: \(error.localizedDescription)")
            }
        }
    }

    func testLogIn() {
        firebaseService.logIn(email: "test@example.com", password: "TestPassword123") { result in
            switch result {
            case .success(let authResult):
                print("Вход успешен: \(authResult.user.email ?? "нет email")")
            case .failure(let error):
                print("Ошибка при входе: \(error.localizedDescription)")
            }
        }
    }

    func testLogOut() {
        firebaseService.logOut { result in
            switch result {
            case .success:
                print("Выход выполнен успешно")
            case .failure(let error):
                print("Ошибка при выходе: \(error.localizedDescription)")
            }
        }
    }

    func runTests() {
        testRegister()
        testLogIn()
        testLogOut()
    }
}


