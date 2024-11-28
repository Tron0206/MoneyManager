//
//  FirebaseService.swift
//  MoneyManager
//
//  Created by Данила Авдиенко on 23.11.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseAuthService{
    
    static let shared = FirebaseAuthService()
    
    private init() {}
    
    func register(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>)->Void){
        
        Auth.auth().createUser(withEmail: email, password: password){res, err in
            if let error = err{
                completion(.failure(error))
            } else if let authResult = res{
                completion(.success(authResult))
            }
        }}
    
    //Функция для входа в аккаунт
    func logIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            if let error = err {
                completion(.failure(error))
            } else if let authResult = res {
                let userId = authResult.user.uid
                completion(.success(userId))
            }
        }
    }
    
    //Функция для выхода из аккаунта
    func logOut(completion: @escaping(Result<Void, Error>) -> Void){
        do{
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
            
    }
}
