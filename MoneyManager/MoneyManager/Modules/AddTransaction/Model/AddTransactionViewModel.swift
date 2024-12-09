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
    @Published var originalTransaction: TransactionModel?
        
    @Published var transactionName: String = ""
    @Published var transactionValue: String = ""
    @Published var transactionDate: Date = Date()
    @Published var transactionType: TransactionType = .expense
    @Published var transactionDescription: String = ""
    @Published var selectedCategory: String? = nil
    @Published var transactionID: String? = nil
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }
    
    private var dataService: DataService
    
    init(dataService: DataService, editTransaction: TransactionModel? = nil) {
        self.dataService = dataService 
        if let editTransaction {
            self.originalTransaction = editTransaction
            self.transactionName = editTransaction.name
            self.transactionValue = String(editTransaction.value)
            self.transactionDate = dateFormatter.date(from: editTransaction.date)!
            self.transactionType = editTransaction.transactionType
            self.transactionDescription = editTransaction.description
            self.selectedCategory = editTransaction.categoryType.name
            self.transactionID = editTransaction.id
        }
    }
    
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
    
    func addTransaction(isEditMode: Bool) throws {
        try validate()
        
        let dateString = dateFormatter.string(from: transactionDate)
        
        let doubleValue = Double(transactionValue.replacingOccurrences(of: ",", with: "."))
        
        if isEditMode {
            if originalTransaction!.transactionType != transactionType
            {
                dataService.deleteTransaction(type: originalTransaction!.transactionType, transactionID: originalTransaction!.id)
                dataService.addTransaction(
                    type: transactionType,
                    name: transactionName,
                    category: selectedCategory!,
                    fee: doubleValue!,
                    date: dateString,
                    description: transactionDescription
                )
            } else {
                dataService.editTransaction(
                    type: transactionType,
                    name: transactionName,
                    category: selectedCategory!,
                    fee: doubleValue!,
                    date: dateString,
                    description: transactionDescription,
                    transactionID: transactionID!
                )
            }
        } else {
            dataService.addTransaction(
                type: transactionType,
                name: transactionName,
                category: selectedCategory!,
                fee: doubleValue!,
                date: dateString,
                description: transactionDescription
            )
        }
    }
}
