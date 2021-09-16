//
//  TranscriptionManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 14/09/2021.
//

import Foundation
import UIKit
import FirebaseFirestore


struct TranscriptionManager{
    
    let db = Firestore.firestore()
    static let shared = TranscriptionManager()
    
    
    private init(){
        
    }
    //    store transcriptions
    func createTranscription(date:Date,title:String,desc:String,completion: @escaping (Result<Void,Error>) -> Void){
            let transcriptionData:[String : Any] = [
                "user_id":userDefaultManager.userDetails.uuid,
                "date":date,
                "title":title,
                "description":desc,
                "timestamp":FieldValue.serverTimestamp()
            ]
            db.collection(Constants.DBCollection.transcriptions).document("new transcription").setData(transcriptionData) { error in
                if let err = error {
                    completion(.failure(err))
                    print("\(err.localizedDescription)")
                }else{
                    completion(.success(()))
                    print("Transcription added")
                }
            }
        }
    func getTranscriptions(completion: @escaping (Result<[String:Any],Error>) -> Void){
        db.collection(Constants.DBCollection.transcriptions).document("new transcription").addSnapshotListener({ snapshot, error in
            guard let document = snapshot else{
                return
            }
            if let err = error{
                print("\(err.localizedDescription)")
                completion(.failure(err))
            }else if let data = document.data(){
//                 print("Current data:\(data)")
                 completion(.success(data))
            }
           
                
            
          
        
        })
    }
}
