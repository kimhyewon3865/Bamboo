//
//  MyPage.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 26..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class MyPage: ResponseObjectSerializable,  ResponseCollectionSerializable {
    
    let code: String
    let type: String
    let contents: String
    let date: String
    let day: String
    let time: String
    let isNotice: String
    var likeCnt: String
    var commentCnt: String
    var keywords: String
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.code = representation.valueForKeyPath("b_code") as! String
        self.type = representation.valueForKeyPath("type") as! String
        self.contents = representation.valueForKeyPath("b_contents") as! String
        self.date = representation.valueForKeyPath("date") as! String
        self.day = representation.valueForKeyPath("day") as! String
        self.time = representation.valueForKeyPath("time") as! String
        self.isNotice = representation.valueForKeyPath("b_notice_yn") as! String
        self.likeCnt = representation.valueForKeyPath("like_cnt") as! String
        self.commentCnt = representation.valueForKeyPath("comment_cnt") as! String
        self.keywords = representation.valueForKeyPath("keyword") as! String
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [MyPage] {
        var myPages: [MyPage] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let myPage = MyPage(response: response, representation: userRepresentation) {
                    myPages.append(myPage)
                }
            }
        }
        
        return myPages
    }
}