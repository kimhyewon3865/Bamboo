//
//  Keyword.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 16..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class Keyword : ResponseObjectSerializable,  ResponseCollectionSerializable {
    //let index : Int
    //let code : String //배열로 놓아야하는지?
    let keyword : String
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.keyword = representation.valueForKeyPath("keyword") as! String
        
    }
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Keyword] {
        var keywordArray : [Keyword] = []
        if let representation = representation as? [[String: AnyObject]] {
            for keywordRepresentation in representation {
                if let keyword = Keyword(response: response, representation: keywordRepresentation) {
                    keywordArray.append(keyword)
                }
            }
        }
        
        return keywordArray
    }
}