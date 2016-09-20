//
//  Checkpoint+CoreDataProperties.swift
//  iStatistics
//
//  Created by Anna Lazareva on 20/09/16.
//  Copyright © 2016 Maria Biryukova. All rights reserved.
//

import Foundation
import CoreData

extension Checkpoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Checkpoint> {
        return NSFetchRequest<Checkpoint>(entityName: "Checkpoint");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var value: Int64
    @NSManaged public var onetime: Onetime?

}
