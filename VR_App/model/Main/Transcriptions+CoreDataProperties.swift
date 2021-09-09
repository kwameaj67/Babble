//
//  Transcriptions+CoreDataProperties.swift
//  
//
//  Created by Kwame Agyenim - Boateng on 08/09/2021.
//
//

import Foundation
import CoreData


extension Transcriptions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transcriptions> {
        return NSFetchRequest<Transcriptions>(entityName: "Transcriptions")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}
