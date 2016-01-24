//
//  CountTimeManager.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 1. 13..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

//extension NSDate
class CountTimeManager {
    func compareDate(dateToCompare: NSDate) -> String    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let date1 : NSDate = NSDate()
        let date2 : NSDate = dateToCompare.dateByAddingTimeInterval(-NSTimeInterval(60*10))
        let interval = date1.timeIntervalSinceDate(date2)
        if interval < 3600 && interval >= 60 {
            print(interval)
            print(Int(interval/60))
            return "\(Int(interval/60))" + "분전"
        }
        else if interval < 86400 && interval >= 3600 {
            print(interval)
            print(interval/3600)
            return "\(interval/3600)"
        }
        else if interval < 259200  && interval >= 86400 {
            print(interval)
            print(interval/86400)
            return "\(interval/86400)"
        }
        else if interval < 60 {
            return "방금"
        }
        else {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.stringFromDate(dateToCompare)
        }
    }
}


//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyyMMddHHmmss"
//    let dateToCompareTmp = "20160123230000"
//    let olderDate = dateFormatter.dateFromString(dateToCompareTmp)
//    let older = dateFormatter.dateFromString("20160124010000")
//    let date1 : NSDate = older!
//    let date2 : NSDate = olderDate!
//
//    let interval = date1.timeIntervalSinceDate(date2)
//
//    if interval < 3600 && interval >= 60 {
//    print(interval)
//    print(interval/60)
//    }
//    else if interval < 86400 && interval >= 3600 {
//    print(interval)
//    print(interval/3600)
//    }
//    else if interval < 259200  && interval >= 86400 {
//    print(interval)
//    print(interval/86400)
//    }
//    else if interval < 60 {
//    print("방금")
//    }

//{
//    func isEqualThanDate(dateToCompare: NSDate) -> String    {
//        //Declare Variables
//        //var isEqualTo = false
//
//        //let olderDate =
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyyMMddHHmmss"
//        var str = ""
//
//        var olderDate = dateToCompare.dateByAddingTimeInterval(-NSTimeInterval(60*10))
//        var checking = olderDate.compare(dateToCompare)
//
//        print("olderDate")
//        print(olderDate)
//        print(NSDate())
//
//        switch checking {
//        case .OrderedDescending:
//            print("DESCENDING123")
//        case .OrderedAscending:
//            print("ASCENDING123")
//            str = dateFormatter.stringFromDate(olderDate)
//        case .OrderedSame:
//            print("SAME123")
//            str = dateFormatter.stringFromDate(dateToCompare)
//            olderDate = dateToCompare
//
//        }
//
//
//        print("s")
//        print(str)
//
//        //var dateToCompareTmp = "\(int)" //String(int)
//        //let olderDate = dateFormatter.dateFromString(dateToCompareTmp)
//
//        let order = NSCalendar.currentCalendar().compareDate(NSDate(), toDate: olderDate,
//            toUnitGranularity: .Day)
//
//
//
//
//        switch order {
//        case .OrderedDescending:
//            print("DESCENDING")
//            return timeSpaceCount("D", dateString: str)
//        case .OrderedAscending:
//            print("ASCENDING")
//            return "asc1"
//        case .OrderedSame:
//            print("SAME")
//            return isEqualThanHour(olderDate)
//        }
//
//    }
//
//    public func isEqualThanHour(dateToCompare: NSDate)-> String {
//        print(dateToCompare)
//        let order = NSCalendar.currentCalendar().compareDate(NSDate(), toDate: dateToCompare,
//            toUnitGranularity: .Hour)
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyyMMddHHmmss"
//        let str = dateFormatter.stringFromDate(dateToCompare)
//
//        switch order {
//        case .OrderedDescending:
//            print("DESCENDING")
//            return timeSpaceCount("H", dateString: str)
//        case .OrderedAscending:
//            print("ASCENDING")
//            return "asc2"
//        case .OrderedSame:
//            print("SAME")
//            return isEqualThanMinute(dateToCompare)
//        }
//
//    }
//
//    public func isEqualThanMinute(dateToCompare: NSDate)-> String {
//        let order = NSCalendar.currentCalendar().compareDate(NSDate(), toDate: dateToCompare,
//            toUnitGranularity: .Minute)
//
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyyMMddHHmmss"
//        let str = dateFormatter.stringFromDate(dateToCompare)
//
//
//        switch order {
//        case .OrderedDescending:
//            print("DESCENDING")
//            return timeSpaceCount("M", dateString: str)
//        case .OrderedAscending:
//            print("ASCENDING")
//            return timeSpaceCount("M", dateString: str)
//            //return "Asc3"
//        case .OrderedSame:
//            print("SAME")
//            return "방금"
//        }
//    }
//
//    public func timeSpaceCount(type: String, dateString: String) -> String {
//        var commentTime = ""
//        var nowTime = ""
//
//        var timespace = ""
//
//        let now = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyyMMddHHmmss"
//        let str = dateFormatter.stringFromDate(now)
//
//
//        if type == "M" {
//            var i = 0
//            for c in dateString.characters {
//                i++
//                if i == 11 {
//                    print(c)
//                    commentTime = commentTime + String(c)
//                }
//                if i == 12 {
//                    commentTime = commentTime + String(c)
//                }
//            }
//
//            i = 0
//            for ch in str.characters {
//                i++
//                if i == 11 {
//                    print(ch)
//                    nowTime = nowTime + String(ch)
//                }
//                if i == 12 {
//                    nowTime = nowTime + String(ch)
//                }
//            }
//
//            timespace = String(Int(nowTime)! - Int(commentTime)!) + "분전"
//        }
//
//        else if type == "H" {
//            var i = 0
//            for c in dateString.characters {
//                i++
//                if i == 9 {
//                    print(c)
//                    commentTime = commentTime + String(c)
//                }
//                if i == 10 {
//                    commentTime = commentTime + String(c)
//                }
//            }
//
//            i = 0
//            for ch in str.characters {
//                i++
//                if i == 9 {
//                    print(ch)
//                    nowTime = nowTime + String(ch)
//                }
//                if i == 10 {
//                    nowTime = nowTime + String(ch)
//                }
//            }
//
//            timespace = String(Int(nowTime)! - Int(commentTime)!) + "시간전"
//        }
//
//        else if type == "D" {
//            var i = 0
//            for c in dateString.characters {
//                i++
//                if i == 9 {
//                    print(c)
//                    commentTime = commentTime + String(c)
//                }
//                if i == 10 {
//                    commentTime = commentTime + String(c)
//                }
//            }
//
//            i = 0
//            for ch in str.characters {
//                i++
//                if i == 9 {
//                    print(ch)
//                    nowTime = nowTime + String(ch)
//                }
//                if i == 10 {
//                    nowTime = nowTime + String(ch)
//                }
//            }
//            if Int(commentTime)! - Int(nowTime)! > 23 {
//                i = 0
//                for c in dateString.characters {
//                    i++
//                    if i == 7 {
//                        print(c)
//                        commentTime = commentTime + String(c)
//                    }
//                    if i == 8 {
//                        commentTime = commentTime + String(c)
//                    }
//                }
//
//                i = 0
//                for ch in str.characters {
//                    i++
//                    if i == 7 {
//                        print(ch)
//                        nowTime = nowTime + String(ch)
//                    }
//                    if i == 8 {
//                        nowTime = nowTime + String(ch)
//                    }
//                }
//
//                if Int(nowTime)! - Int(commentTime)! <= 30 {
//                    timespace = String(Int(nowTime)! - Int(commentTime)!) + "일전"
//                }
//                else {
//                    timespace = dateString
//                }
//            }
//            //else if Int(nowTime)! - Int(commentTime)! <
//            else{
//                var nowTimeT = ""
//                var commentTimeT = ""
//
//                var i = 0
//                for c in dateString.characters {
//                    i++
//                    if i == 11 {
//                        print(c)
//                        commentTimeT = commentTimeT + String(c)
//                    }
//                    if i == 12 {
//                        commentTimeT = commentTimeT + String(c)
//                    }
//                }
//
//                i = 0
//                for ch in str.characters {
//                    i++
//                    if i == 11 {
//                        print(ch)
//                        nowTimeT = nowTimeT + String(ch)
//                    }
//                    if i == 12 {
//                        nowTimeT = nowTimeT + String(ch)
//                    }
//                }
//
//                if Int(commentTimeT)! - Int(nowTimeT)! < 60 {
//                    timespace = String(Int(commentTimeT)! - Int(nowTimeT)!) + "분전"
//
//                }
//                else {
//                    timespace = String(Int(nowTime)! - Int(commentTime)!) + "시간전"
//                }
//            }
//
//        }
//
//        return timespace
//    }


