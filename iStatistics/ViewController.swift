//
//  ViewController.swift
//  test
//
//  Created by Anna Lazareva on 16/09/16.
//  Copyright © 2016 Anna Lazareva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTestData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTestData() {
        if let path = Bundle.main.path(forResource: "testData", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    if let statistics : [NSDictionary] = jsonResult["statistics"] as? [NSDictionary] {
                        for stat: NSDictionary in statistics {
                            print("\(stat)")
                        }
                    }
                } catch {}
            } catch {}
        }
    }


}

