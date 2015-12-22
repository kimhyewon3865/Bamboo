//
//  UniversityManager.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 22..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class UniversityManager: NSObject {
    private var universities = [University]()
    
    override init() {
        super.init()
        writePlistFileAtFirstLaunch()
        self.universities = readDataFromPlistFile()
    }
    
    private func readDataFromPlistFile() -> [University] {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = (paths as NSString).stringByAppendingPathComponent("UniversityList.plist")
        
        var universities = [University]()
        
        let fileArray = NSArray(contentsOfFile: path)
        
        if fileArray != nil {
            for index in 0 ..< fileArray!.count {
                universities.append(University(name: fileArray![index] as! String))
            }
        } else { }
        
        return universities
    }
    
    private func writePlistFileAtFirstLaunch() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = (paths as NSString).stringByAppendingPathComponent("UniversityList.plist")
        let fileManager = NSFileManager.defaultManager()
        
        if (!(fileManager.fileExistsAtPath(path)))
        {
            let bundle : NSString = NSBundle.mainBundle().pathForResource("UniversityList", ofType: "plist")!
            do {
                try fileManager.copyItemAtPath(bundle as String, toPath: path)
            } catch _ {
            }
        }
    }
    
    func getUniversities() -> [University] {
        return self.universities
    }
    
    func getNameFromUniversities() -> [String] {
        var univNames = [String]()
        
        for index in 0 ..< getUniversities().count {
            univNames.append(self.universities[index].name)
        }
        return univNames
    }
}
