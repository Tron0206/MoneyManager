//
//  PieChart.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI


struct PieChartView: View {
    @EnvironmentObject var modelData: ModelData
    
    let categories: [Category]
    var type: TransactionType
        
    var body: some View {
        Canvas { context, size in
            let total = type == .income ? Double(modelData.totalIncome) : Double(modelData.totalExpenses)

            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.48
            var startAngle = Angle.zero
            
            let slices: [(Double, Color)] = categories.map { category in
                let value = type == .income ? Double(category.income) : Double(category.expenses)
                return (value, category.getColor())
            }
                 
            for (value, color) in slices {
                let angle = Angle(degrees: 360 * (value / total))
                let endAngle = startAngle + angle
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(color))
                startAngle = endAngle
                }
            }
            .aspectRatio(1, contentMode: .fit)
    }
}


#Preview {
    PieChartView(categories: ModelData().categories, type: .income)
        .environmentObject(ModelData())
}
