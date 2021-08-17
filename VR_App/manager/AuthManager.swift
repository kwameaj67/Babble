//
//  AuthManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 17/08/2021.
//

import Foundation
import FirebaseAuth


struct AuthManager{
  
    let auth = Auth.auth()
    
    enum AuthError{
        case unknownError
    }
    
    func signUpUser(withEmail email:String, password:String, completion: @escaping (Result<User,Error>) -> Void){
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let err = error{
                completion(.failure(err))
                print("Error:\(err.localizedDescription)")
            }else if let user = user?.user{
                completion(.success(user))
            }else{
                completion(.failure(AuthError.unknownError as! Error))
            }
        }
    }
    
    func signInUser(withEmail email:String,password:String, completion: @escaping (Result<User,Error>) -> Void){
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let err = error{
                completion(.failure(err))
                print("Error:\(err.localizedDescription)")
            }else if let userId = user?.user{
                completion(.success(userId))
            }else{
                completion(.failure(AuthError.unknownError as! Error))
            }
        }
    }
    
    func logoutUser() -> Result<Void,Error>{
        do {
            try auth.signOut()
            return .success(())
        } catch let error {
            return .failure(error)
        }
    }
}
