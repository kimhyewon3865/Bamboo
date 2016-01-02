//
//  Detail.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 28..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class Detail : ResponseObjectSerializable,ResponseCollectionSerializable {
    
    let code: String
    let contents: String
    let regdt: String
    let imgURL: String
    let movURL: String
    let numberOfComment: Int
    let numberOfLike: Int
    //let keyword: [Keyword]
    //let comment: [Comment]
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {

        self.code = representation.valueForKeyPath("b_code") as! String
        self.contents = representation.valueForKeyPath("b_contents") as! String
        self.regdt = representation.valueForKeyPath("regdt") as! String
        self.imgURL = representation.valueForKeyPath("img_url") as! String
        self.movURL = representation.valueForKeyPath("mov_url") as! String
        self.numberOfComment = Int(representation.valueForKeyPath("comment_cnt") as! String)!
        self.numberOfLike = Int(representation.valueForKeyPath("board_like_cnt") as! String)!
        //self.keyword = Keyword.collection(response: response, representation: representation.valueForKeyPath("")!)
        //self.comment = Comment.collection(response: response, representation: representation.valueForKeyPath("")!)
                
    }
    
    
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Detail]{
        var details : [Detail] = []
        
        if let detailArray = representation as? [[String: AnyObject]] {
            for userRepresentation in detailArray {
                if let detail = Detail(response: response, representation: userRepresentation) {
                    details.append(detail)
                }
            }
        }
        
        return details
    }
    
}