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
    
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    enum StatisticsSort {
        
        enum SortAsccending {
            case Asc, Desc
        }
        case SortByTitle(sortAsccending: SortAsccending)
        case SortBySection(sortAsccending: SortAsccending)
        
        var descriptors:[NSSortDescriptor] {
            switch self {
            case .SortByTitle(sortAsccending: .Asc):
                return [NSSortDescriptor(key: "title", ascending: true)]
            case .SortByTitle(sortAsccending: .Desc):
                return [NSSortDescriptor(key: "title", ascending: false)]
            case .SortBySection(sortAsccending: .Asc):
                return [NSSortDescriptor(key: "sectionRaw", ascending: true), NSSortDescriptor(key: "title", ascending: true)]
            case .SortBySection(sortAsccending: .Desc):
                return [NSSortDescriptor(key: "sectionRaw", ascending: false), NSSortDescriptor(key: "title", ascending: true)]
            }
        }
    }
    
    var sort = StatisticsSort.SortBySection(sortAsccending: .Asc)
    var list:[Statistics] = [Statistics]()
    let coreDataStack = CoreDataStack.instance
    
    static let instance = StatisticsController()
    
    private init() {
        initStatistics()
    }
    
    func initStatistics() {
        
        let request:NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = self.sort.descriptors
        
        do {
            self.list = try CoreDataStack.instance.persistentContainer.viewContext.fetch(request)
        } catch {}
        
    }
}
