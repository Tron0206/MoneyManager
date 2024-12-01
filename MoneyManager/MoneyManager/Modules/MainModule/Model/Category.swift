//
//  Category.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI
import Foundation

struct Category: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var income: Int
    var expenses: Int
    var color: String
    //var date: Date //TODO: Сделать время добавления трат и доходов
    
    func getColor() -> Color {
        return Color(hex: color)
    }
}
