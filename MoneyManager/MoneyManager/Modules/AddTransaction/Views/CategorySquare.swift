//
//  CategorySquare.swift
//  MoneyManager
//
//  Created by Иван Кретов on 30.11.2024.
//

import SwiftUI

struct CategorySquare: View {
    let title: String
    let icon: String
    let iconColor: Color
    
    @Binding var selectedCategory: String?
    
    var isPressed: Bool {
        switch selectedCategory {
            case title: return true
            default: return false
        }
    }
    
    var body: some View {
        Button {
            if isPressed {
                selectedCategory = nil
            } else {
                selectedCategory = title
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
                
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                    
                    Spacer()
                    
                    Text(title)
                        .foregroundColor(.primary)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CategorySquare(title: "Категория", icon: "ellipsis", iconColor: .black, selectedCategory: .constant(nil))
}
