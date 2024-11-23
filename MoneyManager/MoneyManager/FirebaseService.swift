//
//  FirebaseService.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 23.11.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseService{
    
    //Функция для регистрации пользователя
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>)->Void){ //Result<AuthDataResult, Error> - тип данных
        
        Auth.auth().createUser(withEmail: email, password: password){res, err in //Функция firebase, создающая пользователя и отправляющая данные на сервер
            if let error = err{ //записываем параметр в константу и проверяем не равно ли оно нулю (не вернулась ли ошибка)
                completion(.failure(error)) //Возвращаем в наше замыкание ошибку для обработки
            } else if let authResult = res{//Записываем параметр в константу и проверяем равно ли оно истине (получилось ли создать пользователя)
                completion(.success(authResult)) //Возвращаем в наше замыкание результат
            }
        }}
    
    //Функция для входа в аккаунт
    func logIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password){res, err in //Функция Firebase для входа в аккаунт (у ф-ций firebase есть встроенные замыкания для проверки успешности функции)
            if let error = err{
                completion(.failure(error))
            } else if let authResult = res{
                completion(.success(authResult))
            }
        }}
    
    //Функция для выхода из аккаунта
    func logOut(completion: @escaping(Result<Void, Error>) -> Void){
        do{
            try Auth.auth().signOut()
            completion(.success(())) //получилось выполнить - возвращаем войд
        } catch {
            completion(.failure(error)) //не получилось выполнить - возвращаем ошибку
        }
            
    }
}
