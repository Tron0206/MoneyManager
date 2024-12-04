//
//  MoneyManagerApp.swift
//  MoneyManager
//
//  Created by Zhasur Sidamatov on 17.11.2024.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct MoneyManagerApp: App {
    @StateObject private var dataService = DataService()
    private let firebaseService = FirebaseAuthService.shared
    @State private var currentUserId: String?
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .onAppear {
//                    firebaseService.logIn(email: "test1@example.com", password: "TestPassword123") { result in
//                        switch result {
//                        case .success(let userId):
//                            self.currentUserId = userId
//                            print("Вход выполнен. userId: \(userId)")
//                            // Вызываем функции после сохранения userId
//                            dataService.addExpense(userId: userId, category: "Transport", fee: 1000, date: "2024-11-28")
//                            dataService.fetchExpenses(for: userId)
//                            
//                        case .failure(let error):
//                            print("Ошибка входа: \(error.localizedDescription)")
//                        }
//                    }
//                }
        }
    }
}
