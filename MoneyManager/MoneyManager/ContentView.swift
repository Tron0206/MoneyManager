import SwiftUI

struct ContentView: View {
    
    @State private var email = ""
    @State private var pass = ""
    @State private var isSecure: Bool = true
    @State private var isLoginSuccessful: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    HStack {
                        Text("Авторизация")
                            .multilineTextAlignment(.center)
                            .frame(width: 236, height: 38)
//                            .fontWeight(.bold)
                            .font(.custom("SF Pro Text", size: 32))
                    }.position(x: 200, y: 77)
                    
                    VStack {
                        HStack {
                            TextField("E-mail", text: $email)
                                .frame(width: 338.0, height: 48.0)
                                .background(Color("Color_#E6E6E6"))
                                .cornerRadius(5)
                                .padding()
                                .autocapitalization(.none)
                        }
                        HStack {
                            if isSecure {
                                TextField("Пароль", text: $pass)
                                    .cornerRadius(5)
                                
                            } else {
                                SecureField("Пароль", text: $pass)
                                    .cornerRadius(5)
                            }
                            Button(action: {
                                isSecure.toggle()
                            }) {
                                if isSecure {
                                    Image("eye")
                                } else {
                                    Image("eye_crossed_out")
                                }
                            }.offset(x: -10)
                                .foregroundColor(.black)
                            
                        }.frame(width: 338.0, height: 48.0)
                            .background(Color("Color_#E6E6E6"))
                            .padding()
                        
                        
                        Button(action: {
                            if isLoginSuccessful {
                                // проверка данных и, если норм, то:
                                
                            } else {
                                isLoginSuccessful = false
                            }
                        }) {
                            Text("Войти")
                            
                        }.frame(width: 342, height: 43)
                            .cornerRadius(5)
                            .background(Color("Color_#3D5AED"))
                            .font(.custom("SF Pro Text", size: 24))
                            .foregroundColor(.white)
                            .padding()
                        
                        NavigationLink(destination: RegistrationView()) {
                            Text("Регистрация")
                                .frame(width: 342, height: 43)
                                .background(Color(.white))
                                .border(Color("Color_#3D5AED"), width: 1)
                                .font(.custom("SF Pro Text", size: 24))
                                .foregroundColor(.black)
                                .padding()
                        }
                    }.position(x: 200, y: 350)
                }.blur(radius: isLoginSuccessful ? 0: 2)
                
                if !isLoginSuccessful {
                    VStack {
                        VStack {
                            Text("Неверные данные")
                                .font(.title3)
                                .font(.custom("SF Pro Text", size: 5))
                                .offset(y: 10)
//                                .fontWeight(.semibold)
                            
                            VStack {
                                Text("Проверьте корректность введенной")
                                    .font(.custom("SF Pro Text", size: 13))
                                    .frame(maxWidth: .infinity)
                                Text("информации")
                                    .font(.custom("SF Pro Text", size: 13))
                                    .frame(maxWidth: .infinity)
                            }.padding(.bottom, 15.0)
                                .offset(y: 10)
                        
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.gray))
                                                                
                            Button(action: {
                                isLoginSuccessful = true
                            }) {
                                Text("ОК")
                                    .font(.custom("SF Pro Text", size: 18))
                                    .fontWeight(.black)
                                    .foregroundColor(Color("Color_#3D5AED"))
                                    .frame(maxWidth: .infinity)
                                    
                            }
                        }.frame(width: 273, height: 136)
                         .background(Color("Color_#F2F2F2").opacity(0.9))
                         .cornerRadius(14)
                         .multilineTextAlignment(.center)
                         .padding()
                    
                    }
                }
            }.background(Image("background").resizable().ignoresSafeArea())
        }
    }
}


struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var pass1 = ""
    @State private var pass2 = ""
    @State private var error = false
    
    var body: some View {
            ZStack {
                ZStack {
                    HStack(spacing: 10) {
                        Text("Регистрация")
                            .multilineTextAlignment(.center)
                            .frame(width: 236, height: 38)
//                            .fontWeight(.bold)
                            .font(.custom("SF Pro Text", size: 32))
                    }.position(x: 200, y: 77)
                    
                    
                    VStack {
                        TextField("E-mail", text: $email)
                            .frame(width: 338.0, height: 48.0)
                            .background(Color("Color_#E6E6E6"))
                            .cornerRadius(5)
                            .padding()
                            .autocapitalization(.none)
                        
                        TextField("Пароль", text: $pass1)
                            .cornerRadius(5)
                            .frame(width: 338.0, height: 48.0)
                            .background(Color("Color_#E6E6E6"))
                            .padding()
                        
                        TextField("Подтверждение пароля", text: $pass2)
                            .cornerRadius(5)
                            .frame(width: 338.0, height: 48.0)
                            .background(Color("Color_#E6E6E6"))
                            .padding()
                        
                        Button(action: {
                            if pass1 == pass2 {
                                print("регистрация успешна")
                                error = false
                            } else {
                                print("Проверте корр данных")
                                error = true
                            }
                        }) {
                            Text("Зарегистрироваться")
                                .frame(width: 342, height: 43)
                                .cornerRadius(5)
                                .background(Color("Color_#3D5AED"))
                                .font(.custom("SF Pro Text", size: 24))
                                .foregroundColor(.white)
                                .padding(40)
                        }
                    }
                }.blur(radius: error ? 2 : 0)
                
                
                if error {
                    
                    VStack {
                                                
                        VStack {
                            Text("Неверные данные")
                                .font(.title3)
                                .font(.custom("SF Pro Text", size: 5))
                                .offset(y: 10)
//                                .fontWeight(.semibold)
                            
                            VStack {
                                Text("Проверьте корректность введенной")
                                    .font(.custom("SF Pro Text", size: 13))
                                    .frame(maxWidth: .infinity)
                                Text("информации")
                                    .font(.custom("SF Pro Text", size: 13))
                                    .frame(maxWidth: .infinity)
                            }.padding(.bottom, 15.0)
                                .offset(y: 10)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(.gray))
                                
                            
                            Button(action: {
                                error = false
                            }) {
                                Text("ОК")
                                    .font(.custom("SF Pro Text", size: 18))
                                    .fontWeight(.black)
                                    .foregroundColor(Color("Color_#3D5AED"))
                                    .frame(maxWidth: .infinity)
                                    
                            }
                        }.frame(width: 273, height: 136)
                         .background(Color("Color_#F2F2F2").opacity(0.9))
                         .cornerRadius(14)
                         .multilineTextAlignment(.center)
                         .padding()
                    
                    }
                }
            }.background(Image("background").resizable().ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image("icon")
                                .frame(width: 18, height: 24)
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
    ContentView()
}
#Preview {
    RegistrationView()
}
