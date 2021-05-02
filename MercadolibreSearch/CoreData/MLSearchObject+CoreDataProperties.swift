//
//  MLSearchObject+CoreDataProperties.swift
//  
//
//  Created by Roberto Parra Castillo on 01-05-21.
//
//

import Foundation
import CoreData

extension MLSearchObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MLSearchObject> {
        return NSFetchRequest<MLSearchObject>(entityName: "MLSearchObject")
    }

    @NSManaged public var text: String?
    @NSManaged public var mode: String?
    @NSManaged public var lastUpdate: Date?

}
