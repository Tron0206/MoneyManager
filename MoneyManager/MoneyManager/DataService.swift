//
//  DataService.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 24.11.2024.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class DataService: ObservableObject {
    @Published var userId: String? = UserDefaults.standard.string(forKey: "userId")
    
    @Published var expenses: [TransactionModel] = []
    @Published var income: [TransactionModel] = []
    
    @Published var categories: [Category] = []
    
    @Published var isDataLoaded: Bool = false
    
    private let db = Firestore.firestore()

    func loadData() {
        guard let userId = userId else { return }
            
        self.isDataLoaded = false 
            
        fetchTransaction(for: userId, type: .expense) { expenses in
            DispatchQueue.main.async {
                self.expenses = expenses
                self.fetchTransaction(for: userId, type: .income) { income in
                    DispatchQueue.main.async {
                        self.income = income
                        self.makeCategories()
                        self.isDataLoaded = true
                    }
                }
            }
        }
    }
    
    func makeCategories() {
        var categories: [Category] = []
        for category in TransactionModel.CategoryType.allCases {
            categories.append(Category(id: category.rawValue, name: category.name, expenses: [], totalExpenses: 0, income: [], totalIncome: 0, color: category.iconColor))
        }
        for transaction in expenses {
            //print(transaction.categoryType.rawValue)
            categories[transaction.categoryType.rawValue].expenses.append(transaction)
            categories[transaction.categoryType.rawValue].totalExpenses += transaction.value
        }
        for transaction in income {
            //print(transaction.categoryType.rawValue)
            categories[transaction.categoryType.rawValue].income.append(transaction)
            categories[transaction.categoryType.rawValue].totalIncome += transaction.value
        }
        self.categories = categories
    }

    func fetchTransaction(for userId: String, type: TransactionType, completion: @escaping ([TransactionModel]) -> Void) {
        let ref = db.collection("users").document(userId).collection(type.name)
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion([])
                return
            }
            
            if let snapshot = snapshot {
                let transactions = snapshot.documents.compactMap { document -> TransactionModel? in
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let categoryString = data["category"] as? String ?? ""
                    let category = TransactionModel.CategoryType.from(name: categoryString)!
                    let fee = data["fee"] as? Double ?? 0
                    let date = data["date"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let id = document.documentID
                                    
                    return TransactionModel(
                        name: name,
                        value: fee,
                        date: date,
                        transactionType: type,
                        description: description,
                        categoryType: category,
                        id: id
                    )
                }
                completion(transactions)
            } else {
                completion([])
            }
        }
    }

    func addTransaction(userId: String, type: TransactionType, name: String, category: String, fee: Double, date: String, description: String) {
        guard let categoryType = TransactionModel.CategoryType.from(name: category)
        else {
            print("error: неверная категория \(category)")
            return
        }
        
        let ref = db.collection("users").document(userId).collection(type.name).document()
        let transactionID = ref.documentID
        
        let newTransaction = TransactionModel(
            name: name,
            value: fee,
            date: date,
            transactionType: type,
            description: description,
            categoryType: categoryType,
            id: transactionID
        )

        switch type {
            case .income:
                self.income.append(newTransaction)
            case .expense:
                self.expenses.append(newTransaction)
        }
        
        self.makeCategories()

        ref.setData([
            "name": name,
            "category": category,
            "fee": fee,
            "date": date,
            "description": description
        ]) { error in
            if let error = error {
                print("Ошибка при добавлении транзакции \(error.localizedDescription)")
            } else {
                print("Добавили транзакцию \(name) в \(fee)")
            }
        }
    }
    
    func deleteTransaction(userId: String, type: TransactionType, transactionID: String) {
        let ref = db.collection("users").document(userId).collection(type.name).document(transactionID)
        ref.delete { error in
            if let error = error {
                print("Ошибка при удалении транзакции \(error.localizedDescription)")
            } else {
                print("Удалили транзакцию с ID \(transactionID)")
                
                if type == .income {
                    self.income.removeAll { $0.id == transactionID }
                } else if type == .expense {
                    self.expenses.removeAll { $0.id == transactionID }
                }
                
                self.makeCategories()
            }
        }
    }
    
    func editTransaction(userId: String, type: TransactionType, name: String, category: String, fee: Double, date: String, description: String, transactionID: String) {
        guard let categoryType = TransactionModel.CategoryType.from(name: category)
        else {
            print("error: неверная категория \(category)")
            return
        }
        
        let editedTransaction = TransactionModel(
            name: name,
            value: fee,
            date: date,
            transactionType: type,
            description: description,
            categoryType: categoryType,
            id: transactionID
        )
        
        switch type {
            case .income:
                if let index = self.income.firstIndex(where: { $0.id == transactionID }) {
                    self.income[index] = editedTransaction
                }
            case .expense:
                if let index = self.expenses.firstIndex(where: { $0.id == transactionID }) {
                    self.expenses[index] = editedTransaction
                }
        }
        
        let ref = db.collection("users").document(userId).collection(type.name).document(transactionID)
        
        ref.setData([
            "name": name,
            "category": category,
            "fee": fee,
            "date": date,
            "description": description
        ]) { error in
            if let error = error {
                print("Ошибка при изменении транзакции \(error.localizedDescription)")
            } else {
                print("Добавили изменение \(name) в \(fee)")
            }
        }
        
        self.makeCategories()
    }
}
