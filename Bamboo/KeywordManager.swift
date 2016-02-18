//
//  KeywordManager.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 1. 9..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

class KeywordManager {
    func getOriginalString(originString originString: String) -> String {
        return originString
    }
    
    func getKeywordAndContentsFromString(originString originString: String) -> (String,String) {
        var keywords: [String] = []
        var contents: String = originString
        
        keywords = extractKeywordFromContents(contents: contents)
        contents = removeKeywordFromString(contents: contents, removeStrings: keywords)

        var retKeyword = ""
        for keyword in keywords {
            retKeyword = retKeyword + keyword
        }

        return (retKeyword,contents)
    }
    
    private func extractKeywordFromContents(contents contents: String) -> [String] {
        
        var newContents = contents
        var retKeywords: [String] = []
        var characterIndex = 0
        var endPoint = 0
        
        for character in contents.characters {
            if character == "#" {
                newContents = contents.substringWithRange(Range<String.Index>(start: contents.startIndex.advancedBy(characterIndex), end: contents.endIndex))
                newContents.removeAtIndex(newContents.startIndex)
                endPoint = characterIndex
                for modifiedCharacter in newContents.characters {
                    if modifiedCharacter == "#" || modifiedCharacter == " " || modifiedCharacter == newContents[newContents.endIndex.predecessor()] {
                        if modifiedCharacter == newContents[newContents.endIndex.predecessor()] {
                            endPoint++
                        }
                        retKeywords.append(contents.substringWithRange(Range<String.Index>(start: contents.startIndex.advancedBy(characterIndex), end: contents.startIndex.advancedBy(endPoint+1))))
                        break
                    }
                    endPoint++
                }
            }
            characterIndex++
        }
        
        return retKeywords
    }
    
    private func removeKeywordFromString(contents contents: String, removeStrings: [String]) -> String {
        var retContents = contents
        
        for removeStr in removeStrings {
            retContents = retContents.replace(removeStr, withString: "")
        }
        
        while retContents[retContents.startIndex] == " " {
            retContents.removeAtIndex(retContents.startIndex)
        }
        return retContents
    }
}

extension String {
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}