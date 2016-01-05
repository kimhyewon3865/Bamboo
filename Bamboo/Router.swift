//
//  Router.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 24..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURL = NSURL(string: "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API")!
    
    case GetMyInfo(uuid: String)
    case GetMyPage(uuid: String, type: String)
    case GetDetail(bCode: String)
    case GetList(type: String, page: String, university: String)
    case SetDefault(uuid: String, university: String)
    case SetUniversity(uuid: String, university: String)
    case SetComment(uuid: String, bCode: String, comment: String)
    case SetLike(uuid: String, bCode: String)
    case SetPoint(uuid: String)
    case SetPointReturn(uuid: String)

    var URL: NSURL {
        return Router.baseURL.URLByAppendingPathComponent(route.path)
    }
    
    var route: (path: String, parameters: [String: AnyObject]?) {
        switch self {
        case .GetMyInfo(let uuid):
            return ("/Bamboo_Get_MyInfo.php", ["uuid": "\(uuid)"])
        case .GetMyPage(let uuid, let type):
            return ("/Bamboo_Get_MyPage.php", ["uuid": "\(uuid)", "type": "\(type)"])
        case .GetDetail(let bCode):
            return ("/Bamboo_Get_Detail.php", ["b_code": "\(bCode)"])
        case .GetList(let type, let page, let university):
            return ("/Bamboo_Get_List.php", ["type": "\(type)", "page": "\(page)", "university": "\(university)"])
        case .SetDefault(let uuid, let university):
            return ("/Bamboo_Set_Default.php", ["uuid": "\(uuid)", "university": "\(university)"])
        case .SetUniversity(let uuid, let university):
            return ("/Bamboo_Set_University.php", ["uuid": "\(uuid)", "university": "\(university)"])
        case .SetComment(let uuid, let bCode, let comment):
            return ("/Bamboo_Set_Comment.php", ["uuid": "\(uuid)", "b_code": "\(bCode)", "comment": "\(comment)"])
        case .SetLike(let uuid, let bCode):
            return ("/Bamboo_Set_Like.php", ["uuid": "\(uuid)", "b_code": "\(bCode)"])
        case .SetPoint(let uuid):
            return ("/Bamboo_Set_Point.php", ["uuid": "\(uuid)"])
        case .SetPointReturn(let uuid):
            return ("/Bamboo_Set_Point_Return.php", ["uuid": "\(uuid)"])
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        return Alamofire
            .ParameterEncoding
            .URL
            .encode(NSURLRequest(URL: URL), parameters: (route.parameters ?? [ : ])).0
    }
}
