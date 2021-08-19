//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Kwame Agyenim - Boateng on 18/08/2021.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var identity: String?
    @NSManaged public var username: String?
    @NSManaged public var uuid: UUID?

}
