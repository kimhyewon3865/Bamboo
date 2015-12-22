//
//  University.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 22..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class University: NSObject {
    var name: String!
    
    init(name: String) {
        self.name = name
    }
    
    override var description: String {
        return "University Name: \(self.name)"
    }
}