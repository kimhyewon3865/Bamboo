//
//  User.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 15..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class User: ResponseObjectSerializable {
    
    static var instance: User!
    
    var uuid: String
    var point: String
    var univ : String
    
    class func sharedInstance() -> User {
        self.instance = (self.instance ?? User())
        return self.instance
    }
    
    init() {
        self.uuid = ""
        self.point = ""
        self.univ = ""
    }

    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.uuid = representation.valueForKeyPath("m_uuid") as! String
        self.point = representation.valueForKeyPath("m_point") as! String
        self.univ = representation.valueForKeyPath("m_univ") as! String
    }
}
