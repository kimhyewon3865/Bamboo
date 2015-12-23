//
//  NetworkManager.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 23..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

enum ListRequestType {
    case GeneralNew
    case GeneralLike
    case UniversityNew
    case UniversityLike
    case Notice
}

class NetworkManager: NSObject {
    private var generalBoards = [GeneralBoard]()
    private var univBoards = [UnivBoard]()
    private var comments = [Comment]()
    
    override init() {
        super.init()
    }
    
    func getList(type: ListRequestType, page: String, univName: String) -> [GeneralBoard] {
        switch type {
        case .GeneralNew :
            Alamofire
                .request(
                    .GET
                    , "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Get_List.php"
                    , parameters : ["type" : "T01", "page" : page, "university" : univName])
                .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                    if response.result.isSuccess {
                        self.generalBoards = response.result.value!
                    }
                }
            return self.generalBoards
        /*
        case .GeneralLike :
        case .UniversityNew :
        case .UniversityLike :
        case .Notice :
        */
        default : break
        }
        return self.generalBoards
    }
}
