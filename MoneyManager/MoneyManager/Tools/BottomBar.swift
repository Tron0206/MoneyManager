//
//  BottomBar.swift
//  MoneyManager
//
//  Created by Иван Кретов on 26.11.2024.
//

import SwiftUI

struct BottomBar: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var appViewMod: appViewModel
    
    var body: some View {
        ZStack() {
            Rectangle()
                .fill(Color(hex: "498DB4"))
                .frame(height: 92)
                .cornerRadius(25.0)
            HStack(alignment: .center) {
                Button {
                    UserDefaults.standard.set(false, forKey: "isLogin")
                    appViewMod.isLogin = false
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "498DB4"))
                            .cornerRadius(10.0)
                            .shadow(radius: 5, x: 0, y: 5)
                            .frame(width: 65, height: 46)
                        Image(systemName: "person")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    if selectedTab == 0 {
                        Text("Доходы")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .frame(maxHeight: 25)
                    } else {
                        Text("Расходы")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .frame(maxHeight: 25)
                    }
                    
                    HStack {
                        Button {
                            selectedTab = 0
                        } label: {
                            Circle()
                                .fill(selectedTab == 0 ? Color.white : Color.gray)
                                .frame(width: 7, height: 7)
                        }
                        Button {
                            selectedTab = 1
                        } label: {
                            Circle()
                                .fill(selectedTab == 1 ? Color.white : Color.gray)
                                .frame(width: 7, height: 7)
                        }
                    }
                    .frame(maxHeight: 0)
                }
                
                Spacer()
                
                Button {
                    //do sth
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color(hex: "498DB4"))
                            .cornerRadius(10.0)
                            .shadow(radius: 5, x: 0, y: 5)
                            .frame(width: 65, height: 46)
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                }
            }
            .padding([.leading, .bottom, .trailing], 30)
        }
    }
}

#Preview {
    BottomBar(selectedTab: .constant(0))
}
