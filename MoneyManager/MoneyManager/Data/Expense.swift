//
//  Expense.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 27.11.2024.
//

import Foundation
import SwiftUI

struct Expense: Codable {
    let fee: Double
    let category: String
    let date: String
}
