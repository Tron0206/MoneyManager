//
//  DataStore.swift
//  MoneyManager
//
//  Created by Иван Кретов on 09.12.2024.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    @Published var userId: String? {
        didSet {
            UserDefaults.standard.set(userId, forKey: "userId")
        }
    }
    
    init() {
        userId = UserDefaults.standard.string(forKey: "userId")
    }
}

