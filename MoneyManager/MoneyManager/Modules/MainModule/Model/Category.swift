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

extension Color {
    init(hex: String) {
        var hexSanitized = hex.uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        let rgb = Int(hexSanitized, radix: 16) ?? 0
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self = Color(red: red, green: green, blue: blue)
    }
}
