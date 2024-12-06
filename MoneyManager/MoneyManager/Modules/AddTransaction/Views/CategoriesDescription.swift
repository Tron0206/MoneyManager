//
//  CategoriesDescription.swift
//  MoneyManager
//
//  Created by Иван Кретов on 30.11.2024.
//

import SwiftUI

struct CategoriesDescription: View {
    @Binding var showAllCategories: Bool
    @Binding var transactionDescription: String
    @Binding var selectedCategory: String?
    
    var isPressed: Bool {
        switch selectedCategory {
            case "Другое": return true
            default: return false
        }
    }
    
    let categories: [TransactionModel.CategoryType] = TransactionModel.CategoryType.allCases
    
    var displayedCategories: [TransactionModel.CategoryType] {
        showAllCategories ? Array(categories).dropLast() : Array(categories.prefix(8))
    }
    
    var body: some View {
        ScrollView {
            if showAllCategories {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2), spacing: 10) {
                    ForEach(displayedCategories, id: \.self) { category in
                        CategorySquare(title: category.name, icon: category.icon, iconColor: category.iconColor, selectedCategory: $selectedCategory)
                    }
                }
                .padding([.top, .trailing, .leading])
                .padding(.bottom, 5)
                
                Button {
                    if isPressed {
                        selectedCategory = nil
                    } else {
                        selectedCategory = "Другое"
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isPressed ? Color.gray.opacity(0.3) : Color(UIColor.systemBackground))
                            .frame(height: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0), value: isPressed)
                        
                        HStack() {
                            Image(systemName: "circle.grid.3x3.fill")
                                .foregroundColor(.pink)
                            
                            Spacer()
                            
                            Text("Другое")
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.trailing, 26)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2),spacing: 10) {
                    ForEach(displayedCategories, id: \.self) { category in
                        CategorySquare(title: category.name, icon: category.icon, iconColor: category.iconColor, selectedCategory: $selectedCategory)
                    }
                }
                .padding([.top, .trailing, .leading])
                .padding(.bottom, 5)
                
                Button {
                    showAllCategories.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .frame(height: 40)
                        HStack() {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("Ещё")
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.trailing, 26)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
            }
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    .frame(height: 188)
                
                VStack(alignment: .leading) {
                    Text("Описание")
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $transactionDescription)
                            .padding(.leading, -5)
                            .frame(height: 140)
                        
                        if transactionDescription.isEmpty {
                            Text("Напишите здесь свой комментарий к трате")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                    }
                }
                .padding(10)
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    CategoriesDescription(showAllCategories: .constant(false), transactionDescription: .constant(""), selectedCategory: .constant(nil))
}
