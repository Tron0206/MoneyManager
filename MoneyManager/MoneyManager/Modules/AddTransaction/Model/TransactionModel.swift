//
//  TransactionModel.swift
//  MoneyManager
//
//  Created by Иван Кретов on 01.12.2024.
//

import Foundation

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
        
        var id: Int {
            return self.rawValue + 1
        }
    }
    
    enum TransactionType {
        case income
        case expense
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
