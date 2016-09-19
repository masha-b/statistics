//
//  StatisticsController.swift
//  iStatistics
//
//  Created by Maria Biryukova on 19.09.16.
//  Copyright © 2016 Maria Biryukova. All rights reserved.
//

import Foundation
import CoreData

class StatisticsController {
    
    var statList:[Statistics]!
    var sort:NSString = "typeRow"
    let coreDataStack = CoreDataStack()
    
    //let entity = NSEntityDescription.entityForName("Statistics", inManagedObjectContext: context)
    
    //let context = CoreDataStack().persistentContainer.viewContext
    //let request = NSFetchRequest(entityName:"Album")
    //var manager = CoreDataManager.instance.fetchedResultsController("Statistics", keyForSort: "type")
    static let instance = StatisticsController()
    
    private init() {
        initStatistics()
    }
    
    func initStatistics() {
        
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Statistics", in: context)
        let car = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context) as! Car
        car.name = "Ferrari"
        
        self.statList = CoreDataManager.instance.fetchedResultsController("Statistics", keyForSort: "type")
    }
}
