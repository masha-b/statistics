//
//  Statistics+CoreDataProperties.swift
//  test
//
//  Created by Anna Lazareva on 19/09/16.
//  Copyright © 2016 Anna Lazareva. All rights reserved.
//

import Foundation
import CoreData

extension Statistics {
    
    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var settingsRaw: String?
    @NSManaged var type: NSNumber?
    @NSManaged var unit: String?
    @NSManaged var base: NSNumber?
    @NSManaged var sectionRaw: NSNumber?
    @NSManaged var field: NSNumber?
    
}
