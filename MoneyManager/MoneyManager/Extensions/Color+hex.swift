//
//  Color+hex.swift
//  MoneyManager
//
//  Created by Zhasur Sidamatov on 01.12.2024.
//

import SwiftUI

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
