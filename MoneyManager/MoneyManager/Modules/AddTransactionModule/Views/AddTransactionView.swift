//
//  AddTransactionView.swift
//  MoneyManager
//
//  Created by Иван Кретов on 30.11.2024.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var transactionName: String = ""
    @State private var transactionValue: String = ""
    @State private var transactionDate: Date = Date()
    @State private var transactionType: String = "Расходы"
    @State private var transactionDescription: String = ""
    
    @State private var selectedCategory: String?
    @State private var showAllCategories: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.colorBar)
                    .frame(height: 50)
                    .offset(y: -50)

                Rectangle()
                    .fill(Color.colorBar)
                    .frame(height: 100)
                    .cornerRadius(25.0)
                    .background(Color.clear)
                
                Text("Money Manager")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
            }
            
            
            TextField("Название траты", text: $transactionName)
                .padding(10)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.colorBar.opacity(0.4), lineWidth: 2)
                )
                .padding(.horizontal)
            
            HStack {
                TextField("Сумма", text: $transactionValue)
                    .keyboardType(.decimalPad)
                    .onChange(of: transactionValue) { newValue in
                        var filteredValue = newValue.filter { $0.isNumber || $0 == "," || $0 == "." }
                        
                        if filteredValue.count == 1 && (filteredValue.first == "," || filteredValue.first == ".") {
                            filteredValue = String(filteredValue.dropFirst())
                        }

                        if filteredValue.first == "0" {
                            if filteredValue.count > 1 && filteredValue[filteredValue.index(after: filteredValue.startIndex)] != "." && filteredValue[filteredValue.index(after: filteredValue.startIndex)] != "," {
                                filteredValue = String(filteredValue.dropFirst())
                            }
                        }

                        let decimalCount = filteredValue.filter { $0 == "," || $0 == "." }.count
                        if decimalCount > 1 {
                            filteredValue = String(filteredValue.dropLast())
                        }
                        
                        if let SeparatorIndex = filteredValue.firstIndex(where: { $0 == "," || $0 == "." }) {
                            let afterDecimal = filteredValue[filteredValue.index(after: SeparatorIndex)...]
                            if afterDecimal.count > 2 {
                                filteredValue = String(filteredValue.dropLast())
                            }
                        }

                        transactionValue = filteredValue
                    }
                    .padding(10)
                
                Image(systemName: "rublesign")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding(10)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.colorBar.opacity(0.4), lineWidth: 2)
            )
            .padding(.horizontal)
            
            
            DatePicker(
                "Дата",
                selection: $transactionDate,
                displayedComponents: [.date]
            )
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.colorBar.opacity(0.4), lineWidth: 2)
            )
            .padding(.horizontal, 60)
            
            let sides = ["Расходы", "Доходы"]
            
            
            Picker("Тип", selection: $transactionType) {
                ForEach(sides, id: \.self) { side in
                    Text(side).tag(side)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .padding(.top, 6)
            
            CategoriesDescription(showAllCategories: $showAllCategories, transactionDescription: $transactionDescription, selectedCategory: $selectedCategory)
                .padding(.top, -5)
            
            Spacer()
            
            Button {
                guard !transactionName.isEmpty else {
                    alertMessage = "Введите название транзакции"
                    showAlert = true
                    return
                }
                guard !["0", "0,00", "0,0", "0.00", "0.0", "", "0,", "0."].contains(transactionValue) else {
                    alertMessage = "Введите сумму"
                    showAlert = true
                    return
                }
                guard selectedCategory != nil else {
                    alertMessage = "Выбирите категорию"
                    showAlert = true
                    return
                }
                
                let transactionTypeEnum: TransactionModel.TransactionType = transactionType == "Доходы" ? .income : .expense
                    
                let selectedCategoryEnum: TransactionModel.CategoryType? = selectedCategory.flatMap { categoryString in
                    TransactionModel.CategoryType.allCases.first { $0.name == categoryString }
                }
                    
                
                let transaction = TransactionModel(
                    name: transactionName,
                    value: Double(transactionValue)!,
                    date: transactionDate,
                    transactionType: transactionTypeEnum,
                    description: transactionDescription,
                    categoryType: selectedCategoryEnum!
                )
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.colorBar.opacity(0.5), lineWidth: 2)
                    Text("Готово")
                        .foregroundColor(.primary)
                        .font(.system(size: 20))
                }
                .frame(height: 45)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Ошибка"),
                message: Text(alertMessage),
                dismissButton: .default(Text("Ок"))
            )
        }

    }
}


#Preview {
    AddTransactionView()
}
