//
//  Expense.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 27.11.2024.
//

import Foundation
import SwiftUI

struct Transaction: Codable {
    let name: String
    let fee: Double
    let category: String
    let date: String
    let description: String?
}
