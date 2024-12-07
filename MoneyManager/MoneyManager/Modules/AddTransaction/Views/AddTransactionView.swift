//
//  AddTransactionView.swift
//  MoneyManager
//
//  Created by Иван Кретов on 30.11.2024.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAllCategories: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @ObservedObject var viewModel = AddTransactionViewModel()
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color(hex: "498DB4"))
                    .frame(height: 50)
                    .offset(y: -50)

                Rectangle()
                    .fill(Color(hex: "498DB4"))
                    .frame(height: 100)
                    .cornerRadius(25.0)
                    .background(Color.clear)
                
                Text("Money Manager")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            
            
            TextField("Название траты", text: $viewModel.transactionName)
                .padding(10)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.colorBar.opacity(0.4), lineWidth: 2)
                )
                .padding(.horizontal)
            
            HStack {
                TextField("Сумма", text: $viewModel.transactionValue)
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.transactionValue) { newValue in
                        viewModel.validateValue(newValue: newValue)
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
                selection: $viewModel.transactionDate,
                displayedComponents: [.date]
            )
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.colorBar.opacity(0.4), lineWidth: 2)
            )
            .padding(.horizontal, 60)
            
            Picker("Тип", selection: $viewModel.transactionType) {
                ForEach(TransactionModel.TransactionType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .padding(.top, 6)
            
            CategoriesDescription(showAllCategories: $showAllCategories, transactionDescription: $viewModel.transactionDescription, selectedCategory: $viewModel.selectedCategory)
                .padding(.top, -5)
            
            Spacer()
            
            Button {
                do {
                    try viewModel.addTransaction()
                } catch let error as AddTransactionViewModel.Error {
                    alertMessage = error.errorDescription
                    showAlert = true
                } catch {
                    alertMessage = "Неизвестная ошибка"
                    showAlert = true
                }
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .frame(width: 18, height: 24)
                            .tint(.black)
                        Text("Назад")
                            .foregroundColor(.black)
                            .font(.custom("SF Pro Text", size: 17))
                    }
                }
            }
        }
    }
}


#Preview {
    AddTransactionView()
}
