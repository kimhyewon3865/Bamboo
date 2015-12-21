//
//  Comment.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 16..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class Comment : ResponseObjectSerializable,  ResponseCollectionSerializable{
    let index : Int
    let code : String
    var regdt: String
    var comment : String
    let numberOfLike: Int
    
    init?(response: NSHTTPURLResponse, representation: AnyObject){
        self.index = representation.valueForKeyPath("comment_cnt") as! Int
        self.code = representation.valueForKeyPath("b_code") as! String
        self.regdt = representation.valueForKeyPath("regdt") as! String
        self.comment = representation.valueForKeyPath("comment") as! String
        self.numberOfLike = Int(representation.valueForKeyPath("comment_like_cnt") as! String)!
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
