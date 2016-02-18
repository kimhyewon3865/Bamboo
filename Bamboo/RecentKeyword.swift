//
//  RecentKeyword.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 2. 18..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation
import RealmSwift

class RecentKeyword: Object {
    dynamic var keywordName = ""
    dynamic var searchedDate = NSDate()
}