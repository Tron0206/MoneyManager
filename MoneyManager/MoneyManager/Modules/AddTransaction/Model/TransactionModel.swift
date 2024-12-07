//
//  TransactionModel.swift
//  MoneyManager
//
//  Created by Иван Кретов on 01.12.2024.
//

import Foundation
import SwiftUI

struct TransactionModel {
    enum CategoryType: Int, CaseIterable {
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
            case .other: return "Прочее"
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
            case .other: return "questionmark.circle"
            }
        }
            
        var iconColor: Color {
            switch self {
            case .health: return .red
            case .leisure: return .green
            case .home: return .yellow
            case .products: return .orange
            case .eatingOut: return .gray
            case .transport: return Color.colorBar
            case .education: return .indigo
            case .gifts: return .green
            case .family: return .orange
            case .sport: return .teal
            case .beauty: return .purple
            case .subscription: return .red
            case .gadgets: return .green
            case .wants: return .yellow
            case .connectionAndInternet: return .primary
            case .clothesAndShoes: return .teal
            case .other: return .gray
            }
        }
            
        var id: Int {
            return self.rawValue + 1
        }
    }
    
    enum TransactionType: String, CaseIterable, Identifiable {
        case income = "Доход"
        case expense = "Расход"
        
        var id: Self { self }
    }
    
    var name: String
    var value: Double
    var date: Date
    var transactionType: TransactionType
    var description: String?
    var categoryType: CategoryType
    
    init(name: String, value: Double, date: Date, transactionType: TransactionType, description: String?, categoryType: CategoryType) {
        self.name = name
        self.value = value
        self.date = date
        self.transactionType = transactionType
        self.description = description
        self.categoryType = categoryType
    }
}
