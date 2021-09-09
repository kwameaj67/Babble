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
    
//    reference to managed object context
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
}
