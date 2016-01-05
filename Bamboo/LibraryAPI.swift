//
//  LibraryAPI.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 23..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class LibraryAPI: NSObject {
    private let universityManager: UniversityManager
    private let alertMessageManager: AlertMessageManager
    
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    override init() {
        universityManager = UniversityManager()
        alertMessageManager = AlertMessageManager()
        super.init()
    }
    
    func getUniversities() -> [University] {
        return self.universityManager.getUniversities()
    }
    
    func getNameFromUniversities() -> [String] {
        return self.universityManager.getNameFromUniversities()
    }
    
    func clickNoticeButton(point point: String) -> (title: String, message: String, buttons: [String]) {
        return self.alertMessageManager.clickNoticeButton(point)
    }
    
    func ifLessPointThan10() -> (title: String, message: String) {
        return self.alertMessageManager.ifLessPointThan10()
    }
    
    func clickCellFromUnivSearchVC(univ: String) -> (title: String, message: String) {
        return self.alertMessageManager.clickCellFromUnivSearchVC(univ)
    }
    
    func ifNoSelectedPhoto() -> (title: String, message: String) {
        return self.alertMessageManager.ifNoSelectedPhoto()
    }
}
