//
//  AuthManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 17/08/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


struct AuthManager{
  
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
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
    
//    configure firestore
    func createUserCollection(email:String,gender:String,username:String,identity:String,uid:String,completion:@escaping (Result<Void,Error>) -> Void){
        var ref: DocumentReference? = nil
        let userData: [String:Any] = [
           "email":email,
           "username":username,
           "gender":gender,
           "identity":identity,
           "uuid":uid,
            "timestamp":FieldValue.serverTimestamp()
            ]
        ref = db.collection("users").addDocument(data: userData) { err in
            if let err = err {
                completion(.failure(err))
                print("Error adding document: \(err.localizedDescription)")
            } else {
                completion(.success(()))
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
