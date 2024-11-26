//
//  MainView.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI

enum TransactionType {
    case income
    case expense
}

struct MainView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var showingCalendarFilter = false
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            TopBar(showingCalendarFilter: $showingCalendarFilter)
                .padding(.bottom, -8)
            
            
            TabView(selection: $selectedTab) {
                PageView(categories: modelData.categories, type: .income)
                    .tag(0)
                        
                PageView(categories: modelData.categories, type: .expense)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .padding(.top, 10)
            
            
            BottomBar(selectedTab: $selectedTab)
                .padding(.top, -8)
        }
        .edgesIgnoringSafeArea(.vertical)
        
        
        .actionSheet(isPresented: $showingCalendarFilter) {
            ActionSheet(
                title: Text("A Short Title is Best"),
                message: Text("A message should be a short, complete sentence."),
                buttons: [
                    .default(Text("Action")) {  // TODO: Сделать выбор промежутков времени
                            
                    },
                    .default(Text("Action")) {

                    },
                    .default(Text("Action")) {
                            
                    },
                    .default(Text("Action")) {
                            
                    },
                    .cancel()
                ]
            )
        }
    }
}

#Preview {
    MainView()
        .environmentObject(ModelData())
}
