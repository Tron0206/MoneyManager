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
    var transactionType: TransactionType
    @State var expenses: [Expense] = [ // Пример данных
        Expense(fee: 150.0, category: "Название", date: "2024-11-11", descr: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    ]
    init(category: Category, transactionType: TransactionType) {
            self.category = category
            self.transactionType = transactionType
            self._expenses = State(initialValue: [ //вот здесь будет работать fetchExpenses()
                Expense(fee: 150.0, category: "Название", date: "2024-11-11", descr: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                Expense(fee: 150.0, category: "Название", date: "2024-11-11", descr: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                Expense(fee: 150.0, category: "Название", date: "2024-11-11", descr: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                Expense(fee: 150.0, category: "Название", date: "2024-11-11", descr: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
            ])
        }
    private var bckgColor = Color(red:225/255, green: 225/255, blue: 225/255)
    private var descColor = Color(red: 70/255, green: 70/255, blue: 70/255)
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Верхняя панель
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color(hex: "498DB4"))
                    .frame(height: 130)
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
                .padding(.bottom, 30)
            }
            
            // Список транзакций
            List {
                ForEach(expenses.indices, id: \.self) { index in
                    ExpenseRowView(
                                expense: expenses[index],
                                bckgColor: bckgColor,
                                descColor: descColor
                            )
                        }                
                .onDelete(perform: deleteExpense)
            }
            .listStyle(PlainListStyle())
            .background(Color.white)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        // добавить вызов функции для удаления из базы данных
    }
}

#Preview {
    ExpenseListView(category: Category(id: 1, name: "Еда", income: 0, expenses: 100, color: "#FF5733"), transactionType: .expense)
}
