//
//  SearchKeyword.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 2. 18..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

final class SearchKeyword : ResponseObjectSerializable,  ResponseCollectionSerializable {
    let keyword: String
    let count: String
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.keyword = representation.valueForKeyPath("keyword") as! String
        self.count = representation.valueForKeyPath("count") as! String
    }
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [SearchKeyword] {
        var searchKeywordArray : [SearchKeyword] = []
        if let representation = representation as? [[String: AnyObject]] {
            for keywordRepresentation in representation {
                if let keyword = SearchKeyword(response: response, representation: keywordRepresentation) {
                    searchKeywordArray.append(keyword)
                }
            }
        }
        
        return searchKeywordArray
    }
}