//
//  ExpenseListView.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 01.12.2024.
//

import SwiftUI

struct ExpenseListView: View {
    var category: Category
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataService: DataService
    
    var transactionType: TransactionType
    
    @State private var transactions: [TransactionModel]
        
    @State private var selectedTransaction: TransactionModel?
        
    init(category: Category, transactionType: TransactionType) {
        self.category = category
        self.transactionType = transactionType
        _transactions = State(initialValue: transactionType == .income ? category.income : category.expenses)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }
    
    private var sortedTransactions: [TransactionModel] {
        transactions.sorted { t1, t2 in
            if let date1 = dateFormatter.date(from: t1.date),
                let date2 = dateFormatter.date(from: t2.date) {
                return date1 > date2
            }
            return false
        }
    }
    
    private var bckgColor = Color(red:225/255, green: 225/255, blue: 225/255)
    private var descColor = Color(red: 70/255, green: 70/255, blue: 70/255)
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Верхняя панель
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color(hex: "498DB4"))
                    .frame(height: 100)
                    .cornerRadius(25.0)
                HStack {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }
                label:
                    {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                            Text("Назад")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                    }
                    Spacer()
                    Text(category.name)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, -70)
                    Spacer()
                }
                .padding(.horizontal, 13)
                .padding(.bottom, 10)
            }
            
            // Список транзакций
            List {
                ForEach(sortedTransactions.indices, id: \.self) { index in
                    ZStack {
                        NavigationLink(
                            destination: AddTransactionView(transaction: selectedTransaction),
                            isActive: Binding(
                                get: { selectedTransaction == sortedTransactions[index] },
                                set: { if !$0 { selectedTransaction = nil } }
                            )
                        ) {
                            EmptyView()
                        }
                        .hidden()
                        
                        ExpenseRowView(
                            transaction: sortedTransactions[index],
                            bckgColor: bckgColor,
                            descColor: descColor
                        )
                        .swipeActions(edge: .leading) {
                            Button("Редактировать") {
                                selectedTransaction = sortedTransactions[index]
                            }
                            .tint(.blue)
                        }
                    }
                    .padding(.vertical, -7)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteExpense)
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .onChange(of: dataService.categories) { updatedCategory in
            if let index = updatedCategory.firstIndex(where: { $0.id == category.id }) {
                self.transactions = transactionType == .income ? updatedCategory[index].income : updatedCategory[index].expenses
            }
        }
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        offsets.forEach { index in
            let transaction = transactions[index]
            transactions.remove(at: index)
            dataService.deleteTransaction(userId: dataService.userId!, type: transactionType, transactionID: transaction.id)
        }
    }
}
