//
//  UIViewController+.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 4. 30..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import Foundation

extension UIViewController {
    func catchIt(userInfo: NSNotification) {
        let descriptions = LibraryAPI.sharedInstance.pushNotificationTriggered()
        BBAlertView.alert(descriptions.title, message: descriptions.message, buttons: descriptions.buttons, tapBlock: {(alertAction, position) -> Void in
            if position == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let noticeVC = storyboard.instantiateViewControllerWithIdentifier("noticeVC") as! NoticeViewController
                //self.navigationController?.pushViewController(noticeVC, animated: true)
                self.presentViewController(noticeVC, animated: true, completion: nil)
            }
        })
    }
}