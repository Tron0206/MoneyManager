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
    
    let categories = ["Здоровье", "Досуг", "Дом", "Продукты", "Еда вне дома", "Транспорт", "Образование", "Подарки", "Семья", "Спорт", "Красота", "Подписки", "Гаджеты", "Хотелки", "Связь и интернет", "Одежда и обувь"]
    
    let icons = ["stethoscope.circle.fill", "balloon.fill", "house.fill", "carrot.fill", "fork.knife", "bus.fill", "graduationcap", "gift", "figure.2.and.child.holdinghands", "figure.yoga", "camera.macro", "tag", "macbook.gen1", "star.fill", "wifi", "hanger"]
    
    let iconColors: [Color] = [.red, .green, .yellow, .orange, .gray, .teal, .indigo, .green, .orange, .teal, .purple, .red, .green, .yellow, .primary, .cyan]
    
    struct CategoryItem {
        var category: String
        var icon: String
        var iconColor: Color
    }
        
    var categoriesWithDetails: [CategoryItem] {
        zip(categories, zip(icons, iconColors)).map { CategoryItem(category: $0.0, icon: $0.1.0, iconColor: $0.1.1) }
    }
    
    var displayedCategories: [CategoryItem] {
            showAllCategories ? categoriesWithDetails : Array(categoriesWithDetails.prefix(8))
    }
    
    var body: some View {
        ScrollView {
            if showAllCategories {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2), spacing: 10) {
                    ForEach(displayedCategories, id: \.category) { item in
                        CategorySquare(title: item.category, icon: item.icon, iconColor: item.iconColor, selectedCategory: $selectedCategory)
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
                    ForEach(displayedCategories, id: \.category) { item in
                        CategorySquare(title: item.category, icon: item.icon, iconColor: item.iconColor, selectedCategory: $selectedCategory)
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
