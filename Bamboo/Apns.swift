//
//  Apns.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 2. 23..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class Apns {
    
    static var instance: Apns!
    
    var deviceToken: String
    
    class func sharedInstance() -> Apns {
        self.instance = (self.instance ?? Apns())
        return self.instance
    }
    
    init() {
        deviceToken = ""
    }
}