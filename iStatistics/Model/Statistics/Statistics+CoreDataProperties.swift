//
//  Statistics+CoreDataProperties.swift
//  iStatistics
//
//  Created by Anna Lazareva on 20/09/16.
//  Copyright © 2016 Maria Biryukova. All rights reserved.
//

import Foundation
import CoreData

extension Statistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistics> {
        return NSFetchRequest<Statistics>(entityName: "Statistics");
    }

    @NSManaged public var base: Int64
    @NSManaged public var desc: String?
    @NSManaged public var sectionRaw: Int16
    @NSManaged public var settingsRaw: String?
    @NSManaged public var title: String?
    @NSManaged public var typeRaw: Int16
    @NSManaged public var unit: String?
    @NSManaged public var fields: NSSet?
    @NSManaged public var onetimes: NSSet?

}

extension Statistics {
    
    @objc(addFieldsObject:)
    @NSManaged public func addToFields(_ value: Field)
    
    @objc(removeFieldsObject:)
    @NSManaged public func removeFromFields(_ value: Field)
    
    @objc(addFields:)
    @NSManaged public func addToCheckpoints(_ values: NSSet)
    
    @objc(removeFields:)
    @NSManaged public func removeFromCheckpoints(_ values: NSSet)
    
}
