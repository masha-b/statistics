//
//  Statistics+CoreDataClass.swift
//  iStatistics
//
//  Created by Anna Lazareva on 20/09/16.
//  Copyright © 2016 Maria Biryukova. All rights reserved.
//

import Foundation
import CoreData

enum SectionType:Int16 {
    case Daily=1, Sprint, Other
    
    var title: String {
        switch self {
        case .Daily:
            return "Ежедневная"
        case .Sprint:
            return "Спринт"
        case .Other:
            return "Другое"            
        }
    }
}

enum ResultType:NSNumber {
    case DailyIncrease=1, AverageValue, AverageIncrease, Summ
    
    var title: String {
        switch self {
        case .DailyIncrease:
            return "Ежедневный прирост"
        case .AverageValue:
            return "Среднее значение"
        case .AverageIncrease:
            return "Средний прирост"
        case .Summ:
            return "Сумма"
        }
    }
}

enum StatisticsType:Int16 {
    enum RangeOptionType:Int16 {
        case Min, Max, Step
        var title: String {
            switch self {
            case .Min:
                return "Минимум"
            case .Max:
                return "Максимум"
            case .Step:
                return "Шаг"
            }
        }
    }
    
    enum ValueOptionType:Int16 {
        case Integer, Decimal, Date
        var title: String {
            switch self {
            case .Integer:
                return "Целое число"
            case .Decimal:
                return "Десятичное число"
            case .Date:
                return "Дата"
            }
        }
    }
    
    case Value=1, YesOrNo, Range, Timer
    
    var title: String {
        switch self {
        case .YesOrNo:
            return "Да/Нет"
        case .Range:
            return "Диапазон"
        case .Value:
            return "Значение"
        case .Timer:
            return "Таймер"
        }
    }
    
    var options:[Int16] {
        switch self {
        case .YesOrNo:
            return []
        case .Range:
            return [RangeOptionType.Min.rawValue, RangeOptionType.Max.rawValue, RangeOptionType.Step.rawValue]
        case .Value:
            return [ValueOptionType.Integer.rawValue, ValueOptionType.Decimal.rawValue, ValueOptionType.Date.rawValue]
        case .Timer:
            return []
        }
    }
}

struct StatisticsSettings {
    
    enum SettingOption:String {
        case MainResult = "mainResult"
        case OtherResult = "otherResult"
    }
    
    var mainResult: ResultType = .AverageIncrease
    var results:[ResultType] = [ResultType]()
    
    init(string: String) {
        
        if let data:NSData = string.data(using: String.Encoding.utf8)! as NSData? {
            do {
                let dictionary = try (JSONSerialization.jsonObject(with: data as Data, options: []) as? [SettingOption:AnyObject])!
                self.mainResult = dictionary[.MainResult] as! ResultType
                self.results = dictionary[.OtherResult] as! [ResultType]
            } catch {
                self.mainResult = .AverageValue
                self.results = [ResultType]()
            }
        }
    }
    
    init() {
        self.mainResult = .AverageValue
        self.results = [ResultType]()
    }
    
    init(dictionary: [SettingOption:AnyObject]) {
        self.mainResult = dictionary[.MainResult] as! ResultType
        self.results = dictionary[.OtherResult] as! [ResultType]
    }
    
    func jsonString() -> String{
        let dictionary:[SettingOption:AnyObject] = [
            .MainResult:(self.mainResult as AnyObject),
            .OtherResult: (self.results as AnyObject)
        ]
        do {
            if let data : NSData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) as NSData?{
                return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as! String
            }
        }
        catch {
            return ""
        }
        return ""
    }
    
    func jsonString(dictionary:NSDictionary) -> String{
        do {
            if let data : NSData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) as NSData?{
                return NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as! String
            }
        }
        catch {
            return ""
        }
        return ""
    }
    
}


public class Statistics: NSManagedObject {
    
    static func withDictionary(data:NSDictionary!)-> Statistics {
        let newStatistics = Statistics(context: CoreDataStack.instance.persistentContainer.viewContext)
        return newStatistics.initWithDictionary(data: data)
    }
    
    var section:SectionType {
        if self.sectionRaw > 0 {
            return SectionType(rawValue: self.sectionRaw)!
        }
        return .Other
    }
    
    var type:StatisticsType {
        if self.typeRaw > 0 {
            return StatisticsType(rawValue: self.typeRaw)!
        }
        return .Value
    }
    
    var settings:StatisticsSettings {
        if self.settingsRaw != nil {
            return StatisticsSettings(string:self.settingsRaw!)
        }
        return StatisticsSettings()
    }
    
    func initWithDictionary(data:NSDictionary!)-> Statistics {
        //self.base = data["base"] as! Int64
        self.setValue(data["base"], forKey: "base")
        self.setValue(data["desc"], forKey: "desc")
        self.setValue(data["sectionRaw"], forKey: "sectionRaw")
        self.setValue(data["title"], forKey: "title")
        self.setValue(data["typeRaw"], forKey: "typeRaw")
        self.setValue(data["unit"], forKey: "unit")
        
        let settingsString = self.settings.jsonString(dictionary: data["settingsRaw"] as! NSDictionary)
        self.setValue(settingsString, forKey: "settingsRaw")
        return self
    }
    
    func save() {
        do {
            try self.managedObjectContext!.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }

}
