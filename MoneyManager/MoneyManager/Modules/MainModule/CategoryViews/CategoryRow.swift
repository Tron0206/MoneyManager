//
//  CategoryRow.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI

struct CategoryRow: View {
    var category: Category
    var type: TransactionType
    
    var value: Double {
        switch type {
        case .income:
            return category.totalIncome
        case .expense:
            return category.totalExpenses
        }
    }
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .stroke(Color.gray.opacity(0.3))
                .frame(height: 40)
                .padding(.horizontal, 20)
            HStack {
                Circle()
                    .fill(category.color)
                    .frame(width: 10)
                Text(category.name)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                Spacer()
                Text(value.truncatingRemainder(dividingBy: 1) == 0 ?
                     String(format: "%.0f", value).replacingOccurrences(of: ".", with: ",") + " ₽" :
                     String(format: "%.2f", value).replacingOccurrences(of: ".", with: ",") + " ₽")
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                
                
            }
            .padding(.horizontal, 40)
        }
        .padding(.top, 0.2)
        .foregroundStyle(.primary)
    }
}

#Preview {
    CategoryRow(category: DataService().categories[0], type: .income)
}
