//
//  Category.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI
import Foundation

struct Category: Equatable, Identifiable {
    var id: Int
    var name: String
    var expenses: [TransactionModel]
    var totalExpenses: Double
    var income: [TransactionModel]
    var totalIncome: Double
    var color: Color
}
