//
//  CategoryRow.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI

struct CategoryRow: View {
    var category: Category
    var forWhat: String?
    
    var value: Int {
        switch forWhat {
        case "Income":
            return category.income
        case "Expense":
            return category.expenses
        default:
            return 0
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
                    .fill(category.getColor())
                    .frame(width: 10)
                Text(category.name)
                    .font(.system(size: 14))
                Spacer()
                Text(String(value))
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 40)
        }
        .padding(.top, 0.2)
        .foregroundStyle(.primary)
    }
}

#Preview {
    CategoryRow(category: ModelData().categories[0], forWhat: "Expense")
}
