//
//  MoneyManagerApp.swift
//  MoneyManager
//
//  Created by Zhasur Sidamatov on 17.11.2024.
//

import SwiftUI
import Firebase
@main
struct MoneyManagerApp: App {
    init(){
        FirebaseApp.configure()
        let tester = FirebaseServiceTester()
        tester.testRegister()
        tester.testLogOut()
        tester.testLogIn()
    }
    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
