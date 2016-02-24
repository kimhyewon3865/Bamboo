//
//  Comment.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 16..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class Comment : ResponseObjectSerializable,  ResponseCollectionSerializable{
    //let index : Int
    //let code : String
    var idx : String
    var regdt: String
    var comment : String
    let numberOfLike: String
    var isLike : String

    init?(response: NSHTTPURLResponse, representation: AnyObject){
        //self.index = representation.valueForKeyPath("comment_cnt") as! Int
        //self.code = representation.valueForKeyPath("b_code") as! String        
        self.idx = representation.valueForKeyPath("idx") as! String
        self.regdt = representation.valueForKeyPath("regdt") as! String
        self.comment = representation.valueForKeyPath("comment") as! String
        self.numberOfLike = representation.valueForKeyPath("commentLikeCnt") as! String
        self.isLike = representation.valueForKeyPath("isLike") as! String
    }
    
//    init (idxP: String, commentP: String, regdtP: String) {
//        //let dateFormatter = NSDateFormatter()
////        dateFormatter.dateFormat = "yyyyMMddHHmmss"
////        //let str = dateFormatter.stringFromDate(now)
////        //let str = dateFormatter.stringFromDate(NSDate())
////        let olderDate222 = dateFormatter.dateFromString(regdtP)
////
////        let olderDate = olderDate222!.dateByAddingTimeInterval(-NSTimeInterval(60*10))
////        let str = dateFormatter.stringFromDate(olderDate)
////        
////        print("regdtP")
////        print(str)
//        idx = idxP
//        regdt = regdtP
//        comment = commentP
//        numberOfLike = "0"
//        isLike = "0"
//    }
    
    init (commentP: String, regdtP: String) {
        //let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        //        //let str = dateFormatter.stringFromDate(now)
        //        //let str = dateFormatter.stringFromDate(NSDate())
        //        let olderDate222 = dateFormatter.dateFromString(regdtP)
        //
        //        let olderDate = olderDate222!.dateByAddingTimeInterval(-NSTimeInterval(60*10))
        //        let str = dateFormatter.stringFromDate(olderDate)
        //
        //        print("regdtP")
        //        print(str)
        idx = ""
        regdt = regdtP
        comment = commentP
        numberOfLike = "0"
        isLike = "0"
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Comment]{
        var commentArray :[Comment] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for commentRepresentation in representation {
                if let comment = Comment(response: response, representation: commentRepresentation) {
                    commentArray.append(comment)
                }
            }
        }
        
        return commentArray
    }
}
