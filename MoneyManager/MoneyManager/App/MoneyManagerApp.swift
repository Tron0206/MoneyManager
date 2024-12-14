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
//    @StateObject private var dataService = DataService()
    private let firebaseService = FirebaseAuthService.shared
    @State private var currentUserId: String?
    @StateObject private var modelData = DataService()
    @ObservedObject var appViewMod = appViewModel()
    
    init() {
        FirebaseApp.configure()
        print("Firebase configured")
        if UserDefaults.standard.bool(forKey: "isLogin"){
            appViewMod.isLogin = true}

    }
    
    var body: some Scene {
        WindowGroup {
            if appViewMod.isLogin{
                    MainView()
                    .environmentObject(modelData)
                    .environmentObject(appViewMod)
            }else{
                AuthorizationView()
                    .environmentObject(modelData)
                    .environmentObject(appViewMod)
                    }

                }
        }
    }
