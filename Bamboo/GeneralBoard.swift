//
//  GeneralBoard.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 16..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class GeneralBoard: ResponseObjectSerializable,  ResponseCollectionSerializable {
    
    let code: String
    let contents: String
    let regdt: String
    let imgURL: String
    let movURL: String
    let numberOfComment: Int
    var numberOfLike: Int
    var keywords: String
    var keywordArray: [String] = []
    var islike: String
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.code = representation.valueForKeyPath("b_code") as! String
        self.contents = representation.valueForKeyPath("b_contents") as! String
        self.regdt = representation.valueForKeyPath("regdt") as! String
        self.imgURL = representation.valueForKeyPath("img_url") as! String
        self.movURL = representation.valueForKeyPath("mov_url") as! String
        self.numberOfComment = Int(representation.valueForKeyPath("comment_cnt") as! String)!
        self.numberOfLike = Int(representation.valueForKeyPath("like_cnt") as! String)!
        self.keywords = representation.valueForKeyPath("keyword") as! String
        self.islike = representation.valueForKeyPath("is_like") as! String
        
        if self.keywords != "" {
            let tmpKeywordArray = keywords.characters.split{$0 == ","}.map(String.init)
            keywordArray = tmpKeywordArray
        }
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [GeneralBoard] {
        var generalboards: [GeneralBoard] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let generalboard = GeneralBoard(response: response, representation: userRepresentation) {
                    generalboards.append(generalboard)
                }
            }
        }
        
        return generalboards
    }
}