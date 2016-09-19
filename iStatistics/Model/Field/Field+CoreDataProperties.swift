//
//  Field+CoreDataProperties.swift
//  iStatistics
//
//  Created by Maria Biryukova on 19.09.16.
//  Copyright © 2016 Maria Biryukova. All rights reserved.
//

import Foundation
import CoreData


extension Field {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Field> {
        return NSFetchRequest<Field>(entityName: "Field");
    }

    @NSManaged public var canComment: Bool
    @NSManaged public var requred: Bool
    @NSManaged public var sort: Int16
    @NSManaged public var title: String?
    @NSManaged public var type: Int16
    @NSManaged public var statistics: NSSet?

}

// MARK: Generated accessors for statistics
extension Field {

    @objc(addStatisticsObject:)
    @NSManaged public func addToStatistics(_ value: NSManagedObject)

    @objc(removeStatisticsObject:)
    @NSManaged public func removeFromStatistics(_ value: NSManagedObject)

    @objc(addStatistics:)
    @NSManaged public func addToStatistics(_ values: NSSet)

    @objc(removeStatistics:)
    @NSManaged public func removeFromStatistics(_ values: NSSet)

}
