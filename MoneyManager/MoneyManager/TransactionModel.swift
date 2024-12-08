//
//  TransactionModel.swift
//  MoneyManager
//
//  Created by Иван Кретов on 01.12.2024.
//

import Foundation
import SwiftUI

struct TransactionModel: Equatable {
    enum CategoryType: Int, Identifiable, CaseIterable {
        case health
        case leisure
        case home
        case products
        case eatingOut
        case transport
        case education
        case gifts
        case family
        case sport
        case beauty
        case subscription
        case gadgets
        case wants
        case connectionAndInternet
        case clothesAndShoes
        case other
            
        var name: String {
            switch self {
            case .health: return "Здоровье"
            case .leisure: return "Досуг"
            case .home: return "Дом"
            case .products: return "Продукты"
            case .eatingOut: return "Еда вне дома"
            case .transport: return "Транспорт"
            case .education: return "Образование"
            case .gifts: return "Подарки"
            case .family: return "Семья"
            case .sport: return "Спорт"
            case .beauty: return "Красота"
            case .subscription: return "Подписки"
            case .gadgets: return "Гаджеты"
            case .wants: return "Хотелки"
            case .connectionAndInternet: return "Связь и Интернет"
            case .clothesAndShoes: return "Одежда и Обувь"
            case .other: return "Другое"
            }
        }
            
        var icon: String {
            switch self {
            case .health: return "stethoscope.circle.fill"
            case .leisure: return "balloon.fill"
            case .home: return "house.fill"
            case .products: return "carrot.fill"
            case .eatingOut: return "fork.knife"
            case .transport: return "bus.fill"
            case .education: return "graduationcap"
            case .gifts: return "gift"
            case .family: return "figure.2.and.child.holdinghands"
            case .sport: return "figure.yoga"
            case .beauty: return "camera.macro"
            case .subscription: return "tag"
            case .gadgets: return "macbook.gen1"
            case .wants: return "star.fill"
            case .connectionAndInternet: return "wifi"
            case .clothesAndShoes: return "hanger"
            case .other: return "circle.grid.3x3.fill"
            }
        }
            
        var iconColor: Color {
            switch self {
            case .health: return Color(hex: "E35B5B")
            case .leisure: return Color(hex: "FCA944")
            case .home: return Color(hex: "F7E223")
            case .products: return Color(hex: "98DE69")
            case .eatingOut: return Color(hex: "E187F8")
            case .transport: return Color(hex: "93BCE9")
            case .education: return Color(hex: "431AF9")
            case .gifts: return Color(hex: "289B32")
            case .family: return Color(hex: "F28F2D")
            case .sport: return Color(hex: "229ECB")
            case .beauty: return Color(hex: "D91DE3")
            case .subscription: return Color(hex: "FF2424")
            case .gadgets: return Color(hex: "89F454")
            case .wants: return Color(hex: "FFEC3E")
            case .connectionAndInternet: return Color(hex: "000000")
            case .clothesAndShoes: return Color(hex: "46F0DF")
            case .other: return Color(hex: "E187F8")
            }
        }
            
        var id: Int {
            return self.rawValue + 1
        }
        
        static func from(name: String) -> TransactionModel.CategoryType? {
            return TransactionModel.CategoryType.allCases.first { $0.name == name }
        }
    }
    
    var name: String
    var value: Double
    var date: String
    var transactionType: TransactionType
    var description: String
    var categoryType: CategoryType
    var id: String
    
    init(name: String, value: Double, date: String, transactionType: TransactionType, description: String, categoryType: CategoryType, id: String) {
        self.name = name
        self.value = value
        self.date = date
        self.transactionType = transactionType
        self.description = description
        self.categoryType = categoryType
        self.id = id
    }
}
