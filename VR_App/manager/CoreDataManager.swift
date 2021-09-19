//
//  CoreDataManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 18/08/2021.
//

import Foundation
import CoreData

class CoreDataManager{
 
    static var shared = CoreDataManager()
    private init(){}
    
    var delegate: TranscriptionListDelegate?
    
//    reference to managed object context
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//   method to save the context
    func saveTranscriptions(){
        if context.hasChanges{
            do {
                 try context.save()
                print("Saved")
            } catch  {
                print("Something went wrong whilst saving data!\(error.localizedDescription)")
            }
            fetchTranscriptions()
        }
    }
}
//MARK: - helper functions
extension CoreDataManager{
    
    
    func createTranscription(title:String,text:String){
//        create transcription object
        let note = Transcriptions(context: context)
        note.id = UUID()
        note.date = getDate()
        note.title = title
        note.text = text
//        save note
        saveTranscriptions()
        
    }
    func fetchTranscriptions() -> [Transcriptions]{
        print("Fetch notes...")
        delegate?.refreshTranscriptions()
        return try! context.fetch(Transcriptions.fetchRequest())
    }
    func deleteTranscription(transcript: Transcriptions){
//        remove object
        do {
            print("Deleting note")
            context.delete(transcript)
            //        save data
            saveTranscriptions()
        }
    }
}
