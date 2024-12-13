//
//  MainView.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI

enum TransactionType: Int, CaseIterable, Identifiable {
    case expense = 0
    case income = 1
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .expense: return "Expenses"
        case .income: return "Income"
        }
    }
    
    var nameRussian: String {
        switch self {
        case .expense: return "Расходы"
        case .income: return "Доходы"
        }
    }
}

struct MainView: View {
    @StateObject private var modelData = DataService()
    @State private var showingCalendarFilter = false
    @State private var selectedTab = 0
    
    @State private var isSelectionPeriod = false

    var body: some View {
        Group {
            if !modelData.isDataLoaded {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                NavigationView {
                    VStack {
                        TopBar(showingCalendarFilter: $showingCalendarFilter)
                            .padding(.bottom, -8)
                        
                        TabView(selection: $selectedTab) {
                            PageView(type: .expense)
                                .environmentObject(modelData)
                                .tag(0)
                            
                            PageView(type: .income)
                                .environmentObject(modelData)
                                .tag(1)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .padding(.top, 10)
                        
                        
                        BottomBar(selectedTab: $selectedTab)
                            .environmentObject(modelData)
                            .padding(.top, -8)
                    }
                    .edgesIgnoringSafeArea(.vertical)
                    .actionSheet(isPresented: $showingCalendarFilter) {
                        ActionSheet(
                            title: Text("A Short Title is Best"),
                            message: Text("A message should be a short, complete sentence."),
                            buttons: [
                                .default(Text("День")) {  // TODO: Сделать выбор промежутков времени
                                    
                                },
                                .default(Text("Месяц")) {
                                    
                                },
                                .default(Text("Период")) {
                                    isSelectionPeriod.toggle()
                                },
                                .cancel()
                            ]
                        )
                    }.overlay(
                        isSelectionPeriod ? AnyView(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)) : AnyView(EmptyView())
                    )
                    .overlay(
                        isSelectionPeriod ? AnyView(SelectionPeriodView(showModal: $isSelectionPeriod, showingCalendarFilter: $showingCalendarFilter)) : AnyView(EmptyView())
                    )
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            modelData.loadData()
        }
    }
}
#Preview {
    MainView()
        .environmentObject(DataService())
}
