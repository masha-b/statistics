//
//  Statistics.swift
//  test
//
//  Created by Anna Lazareva on 19/09/16.
//  Copyright © 2016 Anna Lazareva. All rights reserved.
//

import UIKit
import CoreData

enum StatisticsSection:NSNumber {
    case Daily, Sprint, Other
    
    var title: String {
        switch self {
        case .Daily:
            return "Ежедневная"
        case .Sprint:
            return "Спринт"
        default:
            return "Другое"
        }
    }
}

enum StatisticsSettingsViewType:NSNumber {
    case DailyIncrease, AverageValue, AverageIncrease, Summ
    
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

/*enum Wearable {
    enum Weight: Int {
        case Light = 1
        case Mid = 4
        case Heavy = 10
    }
    enum Armor: Int {
        case Light = 2
        case Strong = 8
        case Heavy = 20
    }
    case Helmet(weight: Weight, armor: Armor)
    case Breastplate(weight: Weight, armor: Armor)
    case Shield(weight: Weight, armor: Armor)
}
let woodenHelmet = Wearable.Helmet(weight: .Light, armor: .Light)*/

enum StatisticsType:NSNumber {
    enum RangeOptionType:NSNumber {
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
    
    enum ValueOptionType:NSNumber {
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
    
    case Value, YesOrNo, Range, Timer
    
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
    
    var options:[NSNumber] {
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
    
    var mainResult: StatisticsSettingsViewType = .AverageIncrease
    var results:[StatisticsSettingsViewType] = [StatisticsSettingsViewType]()
    
    init(string: String) {
        if let data = string.data(using: String.Encoding.utf8) {
            do {
                let dictionary = try (JSONSerialization.jsonObject(with: data, options: []) as? [SettingOption:AnyObject])!
                self.mainResult = dictionary[.MainResult] as! StatisticsSettingsViewType
                self.results = dictionary[.OtherResult] as! [StatisticsSettingsViewType]
            } catch {}
        }
    }
    
    init(dictionary: [SettingOption:AnyObject]) {
        self.mainResult = dictionary[.MainResult] as! StatisticsSettingsViewType
        self.results = dictionary[.OtherResult] as! [StatisticsSettingsViewType]
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
    
}

class Statistics: NSManagedObject {
    
    var section:StatisticsSection {
        if self.sectionRaw != nil {
            return StatisticsSection(rawValue: self.sectionRaw!)!
        }
        return .Other
    }
    
    var type:StatisticsType {
        if self.typeRaw != nil {
            return StatisticsType(rawValue: self.typeRaw!)!
        }
        return .Value
    }
    
    var settings:StatisticsSettings {
        return StatisticsSettings(string:self.settingsRaw!)
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
