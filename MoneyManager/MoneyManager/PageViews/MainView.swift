//
//  MainView.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var showingCalendarFilter = false
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
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
            
            
            TabView(selection: $selectedTab) {
                PageIncomeView(categories: modelData.categories)
                    .tag(0)
                        
                PageExpensesView(categories: modelData.categories)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            
            
            ZStack() {
                Rectangle()
                    .fill(Color.colorBar)
                    .frame(height: 92)
                    .cornerRadius(25.0)
                HStack(alignment: .center) {
                    Button {
                        //do sth
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: "#7BA0CC"))
                                .cornerRadius(10.0)
                                .shadow(radius: 5, x: 0, y: 5)
                                .frame(width: 65, height: 46)
                            Image(systemName: "person")
                                .foregroundStyle(.black)
                                .font(.title)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        if selectedTab == 0 {
                            Text("Доходы")
                                .font(.system(size: 20))
                                .frame(maxHeight: 25)
                        } else {
                            Text("Расходы")
                                .font(.system(size: 20))
                                .frame(maxHeight: 25)
                        }
                        
                        HStack {
                            Circle()
                                .fill(selectedTab == 0 ? Color.white : Color.gray)
                                .frame(width: 7, height: 7)
                                        
                            Circle()
                                .fill(selectedTab == 1 ? Color.white : Color.gray)
                                .frame(width: 7, height: 7)
                        }
                        .frame(maxHeight: 0)
                    }
                    
                    Spacer()
                    
                    Button {
                        //do sth
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color(hex: "#7BA0CC"))
                                .cornerRadius(10.0)
                                .shadow(radius: 5, x: 0, y: 5)
                                .frame(width: 65, height: 46)
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                                .font(.title)
                        }
                    }
                }
                .padding([.leading, .bottom, .trailing], 30)
            }
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
