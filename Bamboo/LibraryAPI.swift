//
//  LibraryAPI.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 23..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
    private let universityManager: UniversityManager
    private let networkManager: NetworkManager
    
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    override init() {
        universityManager = UniversityManager()
        networkManager = NetworkManager()
        
        super.init()
    }
    
    func getUniversities() -> [University] {
        return self.universityManager.getUniversities()
    }
    
    func getNameFromUniversities() -> [String] {
        return self.universityManager.getNameFromUniversities()
    }
    
    func getList(type: ListRequestType, page: String, univName: String) -> [GeneralBoard] {
        return self.networkManager.getList(type, page: page, univName: univName)
    }
}
