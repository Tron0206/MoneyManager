//
//  ExpenseRowView.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 04.12.2024.
//

import SwiftUI

struct ExpenseRowView: View {
    var transaction: TransactionModel
    var bckgColor: Color
    var descColor: Color

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(transaction.name).lineLimit(1)
                        .font(.headline)
                    Text("(\(transaction.date))")
                        .font(.caption2)
                        .foregroundStyle(.blue)
                }
                Text(transaction.description).lineLimit(1)
                    .font(.subheadline)
                    .foregroundColor(descColor)
            }
            Spacer()
            Text("\(transaction.value, specifier: "%.2f") ₽")
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
                        .stroke(Color(hex: "498DB4"), lineWidth: 1)
                )
                .padding(.horizontal, -10)
        )
        .listRowSeparator(.hidden)
    }
}
