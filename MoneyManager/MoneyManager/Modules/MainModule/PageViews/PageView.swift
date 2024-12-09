//
//  PageIncome.swift
//  MoneyManager
//
//  Created by Иван Кретов on 22.11.2024.
//

import SwiftUI

struct PageView: View {
    @EnvironmentObject var dataService: DataService
    
    var type: TransactionType
    
    private var transactions: [TransactionModel] {
        switch type {
            case .income:
                return dataService.income
            case .expense:
                return dataService.expenses
        }
    }
    
    var total: Double {
        switch type {
            case .income:
                return transactions.reduce(0) { $0 + $1.value }
            case .expense:
                return transactions.reduce(0) { $0 + $1.value }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color(hex: "498DB4").opacity(0.5), lineWidth: 2)
                    .frame(width: 140, height: 30)
                    .padding(.top, 1)
                Text("17 апр. - 29 сент.")     //TODO: Сделать так чтобы писались выбранные временные промежутки
                    .font(.system(size: 16))
            }
            
            PieChartView(type: type)
                .frame(width: 250.0)
            
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color(hex: "498DB4"), lineWidth: 2.5)
                    .frame(width: 163, height: 45)
                
                HStack {
                    Text("Итого:")
                        .font(.system(size: 16))
                    Text(total.truncatingRemainder(dividingBy: 1) == 0 ?
                         String(format: "%.0f", total).replacingOccurrences(of: ".", with: ",") :
                            String(format: "%.2f", total).replacingOccurrences(of: ".", with: ","))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
            }
                
            ScrollView {
                VStack {
                    ForEach(dataService.categories) { category in
                        if (type == .expense && !category.expenses.isEmpty) || (type == .income && !category.income.isEmpty) {
                            NavigationLink(
                                destination:
                                    ExpenseListView(category: category, transactionType: type)
                                    .environmentObject(dataService)
                            ) {
                                CategoryRow(category: category, type: type)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PageView(type: .expense)
        .environmentObject(DataService())
}
