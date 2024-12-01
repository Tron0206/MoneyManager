//
//  TopBar.swift
//  MoneyManager
//
//  Created by Иван Кретов on 26.11.2024.
//

import SwiftUI

struct TopBar: View {
    @Binding var showingCalendarFilter: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color.colorBar)
                .frame(height: 100)
                .cornerRadius(25.0)
            
            HStack() {
                Spacer()
                Text("Money Manager")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
                    .padding(.leading, 45)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Button {
                    showingCalendarFilter.toggle()
                } label: {
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .padding(.trailing, 25)
            }
        }
    }
}

#Preview {
    TopBar(showingCalendarFilter: .constant(false))
}