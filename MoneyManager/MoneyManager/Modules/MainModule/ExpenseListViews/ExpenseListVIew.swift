//
//  ExpenseListView.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 01.12.2024.
//

import SwiftUI

struct ExpenseListView: View {
    var category: Category
    var transactionType: TransactionType
    @State var expenses: [Expense] = [ // Пример данных
        Expense(fee: 150.0, category: "Название", date: "2024-11-11", descr: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    ]
    init(category: Category, transactionType: TransactionType) {
            self.category = category
            self.transactionType = transactionType
            self._expenses = State(initialValue: [ //вот здесь будет работать fetchExpenses()
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
                    .fill(Color.colorBar)
                    .frame(height: 130)
                    .cornerRadius(25.0)
                HStack {
                    NavigationLink(destination: MainView().environmentObject(ModelData()))
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
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack{
                                Text(expenses[index].category).lineLimit(1)
                                    .font(.headline)
                                Text("(\(expenses[index].date))")
                                    .font(.caption2)
                                    .foregroundStyle(.blue)
                            }
                            Text(expenses[index].descr ?? "").lineLimit(1)
                                .font(.subheadline)
                                .foregroundColor(descColor)
                        }
                        Spacer()
                        Text("$\(expenses[index].fee, specifier: "%.2f")")
                            .font(.body)
                            .foregroundColor(.black)
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 4, trailing: 20))
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(bckgColor)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.colorBar, lineWidth: 1)
                                )
                            .padding(.horizontal, -10)
                    )
                    .listRowSeparator(.hidden)
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
