//
//  ViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 14..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let alamofireManager = Manager()
    let uuid = UIDevice.currentDevice().identifierForVendor!.UUIDString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamofireManager.request(.GET, "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Get_MyInfo.php", parameters:["uuid" : self.uuid])
            .responseObject { (response: Response<User, NSError>) in
                
                if response.result.isSuccess {
                    
                    User.sharedInstance().uuid = (response.result.value?.uuid)!
                    User.sharedInstance().point = (response.result.value?.point)!
                    User.sharedInstance().univ = (response.result.value?.univ)!
                    
                    print(User.sharedInstance().uuid)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

