//
//  SimpleJsonParser.swift
//  Seminar_AWS
//
//  Created by 박태현 on 2015. 11. 28..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import Foundation

class SimpleJsonParser {
    func HTTPGetJson (url : String, callback : (Dictionary<String, AnyObject>, String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        HTTPsendRequest(request) {
            (data: String, error : String?) -> Void in
            if error != nil {
                callback(Dictionary<String, AnyObject>(), error)
            } else {
                let jsonObj = self.JSONParseDict(data)
                callback(jsonObj, nil)
            }
        }
    }
    
    func HTTPsendRequest(request : NSMutableURLRequest, callback : (String, String?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            data, response, error in
            if error != nil {
                callback("error",(error!.localizedDescription) as String)
            } else {
                callback(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String, nil)
            }
        })
        task.resume()
    }
    
    func JSONParseDict(jsonString : String) -> Dictionary<String, AnyObject> {
        if let data : NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                if let jsonObj = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String, AnyObject> {
                    return jsonObj
                }
            } catch {
                print("error")
            }
        }
        return [String : AnyObject]()
    }
}