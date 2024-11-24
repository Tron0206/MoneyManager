//
//  PageIncome.swift
//  MoneyManager
//
//  Created by Иван Кретов on 22.11.2024.
//

import SwiftUI

struct PageIncomeView: View {
    @EnvironmentObject var modelData: ModelData
    
    var categories: [Category]
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.colorBar.opacity(0.5), lineWidth: 2)
                    .frame(width: 140, height: 30)
                    .padding(.top, 1)
                Text("17 апр. - 29 сент.")     //TODO: Сделать так чтобы писались выбранные временные промежутки
                    .font(.system(size: 16))
            }
                
            PieChartView(categories: categories, forWhat: "Income")
                .frame(width: 250.0)
                
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.colorBar, lineWidth: 2.5)
                    .frame(width: 163, height: 45)
                    
                HStack {
                    Text("Итого:")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                    Text("\(modelData.totalIncome)")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
            }
            ScrollView {
                VStack {
                    ForEach(categories) { category in
                        CategoryRow(category: category, forWhat: "Income")
                    }
                }
            }
        }
    }
}

#Preview {
    PageIncomeView(categories: ModelData().categories)
        .environmentObject(ModelData())
}
