//
//  SelectionPeriodView.swift
//  MoneyManager
//
//  Created by ksenia on 02.12.2024.
//

import Foundation
import  SwiftUI

struct SelectionPeriodView: View {
    @Binding var showModal: Bool
    @Binding var showingCalendarFilter: Bool
    @State private var selectedStartDate = Date()
    @State private var selectedEndsDate = Date()

    var body: some View {
        VStack {
             DatePicker("Starts", selection: $selectedStartDate, displayedComponents: .date)
                 .padding(5)
                 .padding(.horizontal, 60)

            Divider()
            DatePicker("Ends", selection: $selectedEndsDate, displayedComponents: .date)
        .padding(.horizontal, 65)

            Divider()

            HStack {
                Button("Готово") {
                    showModal = false
                }
                 .frame(maxWidth: .infinity)
                 .padding([.top, .leading, .bottom])
                 .foregroundColor(.blue)
                 .cornerRadius(10)

                Divider()
                    .frame(height: 50)
            
                Button("Отмена") {
                    showingCalendarFilter = true
                    showModal = false
                }
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom, .trailing])
                .foregroundColor(.red)
                .cornerRadius(10)

            }
        }.padding(.horizontal, -20)
        .background(Color.white)
        .cornerRadius(15)
        .padding()
        .transition(.scale)
   }
}
