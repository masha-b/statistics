//
//  Onetime+CoreDataProperties.swift
//  iStatistics
//
//  Created by Anna Lazareva on 20/09/16.
//  Copyright © 2016 Maria Biryukova. All rights reserved.
//

import Foundation
import CoreData

extension Onetime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Onetime> {
        return NSFetchRequest<Onetime>(entityName: "Onetime");
    }

    @NSManaged public var date: Int64
    @NSManaged public var checkpoints: NSSet?
    @NSManaged public var statistics: Statistics?

}

// MARK: Generated accessors for checkpoints
extension Onetime {

    @objc(addCheckpointsObject:)
    @NSManaged public func addToCheckpoints(_ value: Checkpoint)

    @objc(removeCheckpointsObject:)
    @NSManaged public func removeFromCheckpoints(_ value: Checkpoint)

    @objc(addCheckpoints:)
    @NSManaged public func addToCheckpoints(_ values: NSSet)

    @objc(removeCheckpoints:)
    @NSManaged public func removeFromCheckpoints(_ values: NSSet)

}
