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
    @Published var expenses: [Expense] = []

    func fetchExpenses(for userId: String){
        expenses.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userId).collection("Expenses")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()

                    let category = data["category"] as? String ?? ""
                    let fee = data["fee"] as? Double ?? 0
                    let date = data["date"] as? String ?? ""
                    let descr = data["description"] as? String? ?? ""

                    let expense = Expense(fee: fee, category: category, date: date, descr: descr)
                    self.expenses.append(expense)
                    print("=============Трата=============")
                    print("Category: \(category), Fee: \(fee), Date: \(date), Description: \(descr ?? "")")

                }
            }
        }
    }



    func addExpense(userId: String, category: String, fee: Double, date: String){
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userId).collection("Expenses").document()

        ref.setData([
            "category": category,
            "fee": fee,
            "date": date
//            "descr": descr
        ]){error in
            if let error = error{
                print("Ошибка при добавлении траты \(error.localizedDescription)")
            } else{
                print("Добавили трату в \(fee)")
            }
        }
    }

}
