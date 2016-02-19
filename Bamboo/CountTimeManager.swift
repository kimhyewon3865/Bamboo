//
//  CountTimeManager.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 1. 13..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

class CountTimeManager {
    func compareDate(dateToCompare: NSDate) -> String    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let date1 : NSDate = NSDate()
        //let date2 : NSDate = dateToCompare.dateByAddingTimeInterval(-NSTimeInterval(60*10))
        let interval = date1.timeIntervalSinceDate(dateToCompare)
        if interval < 3600 && interval >= 60 {
            print(interval)
            print(Int(interval/60))
            return "\(Int(interval/60))" + "분전"
        }
        else if interval < 86400 && interval >= 3600 {
            print(interval)
            print(interval/3600)
            return "\(Int(interval/3600))" + "시간전"
        }
        else if interval < 259200  && interval >= 86400 {
            print(interval)
            print(interval/86400)
            return "\(Int(interval/86400))" + "일전"
        }
        else if interval < 60 {
            return "방금"
        }
        else {
            dateFormatter.dateFormat = "yy/MM/dd"
            return dateFormatter.stringFromDate(dateToCompare)
        }
    }
}