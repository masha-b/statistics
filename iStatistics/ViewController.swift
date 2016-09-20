//
//  ViewController.swift
//  test
//
//  Created by Anna Lazareva on 16/09/16.
//  Copyright © 2016 Anna Lazareva. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTestData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTestData() {
        if let path = Bundle.main.path(forResource: "testData", ofType: "json") {
            do {
                if let data:NSData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe) as NSData? {
                    do {
                        let jsonData = try (JSONSerialization.jsonObject(with: data as Data, options: []) as? NSDictionary)!
                        
                        if let statistics : [NSDictionary] = jsonData["statistics"] as? [NSDictionary] {
                            var results:[Statistics] = [Statistics]()
                            for stat: NSDictionary in statistics {
                                let _stat:Statistics = Statistics.withDictionary(data: stat)
                                _stat.save()
                            }
                            StatisticsController.instance.sort = StatisticsController.StatisticsSort.SortByTitle(sortAsccending: .Asc)
                            StatisticsController.instance.initStatistics()
                            results = StatisticsController.instance.list
                            for _statistics: Statistics in results {
                                print(_statistics.section.title + " * " + _statistics.title!)
                            }
                        }
                    } catch {}
                }
            } catch {}
        }
    }


}

