//
//  AddTransactionViewModel.swift
//  MoneyManager
//
//  Created by Иван Кретов on 06.12.2024.
//

import Foundation

class AddTransactionViewModel: ObservableObject {
    enum Error: Swift.Error {
        case invalidValue
        case invalidCategory
        case invalidName
        
        
        var errorDescription: String {
            switch self {
            case .invalidValue:
                return "Введите сумму"
            case .invalidCategory:
                return "Выбирите категорию"
            case .invalidName:
                return "Введите название транзакции"
            }
        }
    }
    
    @Published var transactionName: String = ""
    @Published var transactionValue: String = ""
    @Published var transactionDate: Date = Date()
    @Published var transactionType: TransactionModel.TransactionType = .expense
    @Published var transactionDescription: String = ""
    @Published var selectedCategory: String? = nil
    
    func validate() throws {
        guard !transactionName.isEmpty else { throw Error.invalidName }
        guard !["0", "0,00", "0,0", "0.00", "0.0", "", "0,", "0."].contains(transactionValue) else { throw Error.invalidValue }
        guard selectedCategory != nil else { throw Error.invalidCategory }
    }
    
    func validateValue(newValue: String) {
        var filteredValue = newValue.filter { $0.isNumber || $0 == "," || $0 == "." }
        
        if filteredValue.count == 1 && (filteredValue.first == "," || filteredValue.first == ".") {
            filteredValue = String(filteredValue.dropFirst())
        }

        if filteredValue.first == "0" {
            if filteredValue.count > 1 && filteredValue[filteredValue.index(after: filteredValue.startIndex)] != "." && filteredValue[filteredValue.index(after: filteredValue.startIndex)] != "," {
                filteredValue = String(filteredValue.dropFirst())
            }
        }

        let decimalCount = filteredValue.filter { $0 == "," || $0 == "." }.count
        if decimalCount > 1 {
            filteredValue = String(filteredValue.dropLast())
        }
        
        if let SeparatorIndex = filteredValue.firstIndex(where: { $0 == "," || $0 == "." }) {
            let afterDecimal = filteredValue[filteredValue.index(after: SeparatorIndex)...]
            if afterDecimal.count > 2 {
                filteredValue = String(filteredValue.dropLast())
            }
        }

        transactionValue = filteredValue
    }
    
    func addTransaction() throws {
        try validate()
    
        let selectedCategoryEnum: TransactionModel.CategoryType? = selectedCategory.flatMap { categoryString in
            TransactionModel.CategoryType.allCases.first { $0.name == categoryString }
        }
        
        let transaction = TransactionModel(
            name: transactionName,
            value: Double(transactionValue.replacingOccurrences(of: ",", with: "."))!,
            date: transactionDate,
            transactionType: transactionType,
            description: transactionDescription,
            categoryType: selectedCategoryEnum!
        )
    }
}
