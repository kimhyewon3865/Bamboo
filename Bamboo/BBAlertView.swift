//
//  BBAlertView.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 1. 5..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.

import Foundation

public class BBAlertView {
    
    class var instance : BBAlertView {
        struct Static {
            static let instance: BBAlertView = BBAlertView()
        }
        return Static.instance
    }
    
    private func topMostController() -> UIViewController? {
        var presenetedVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while let pVC = presenetedVC?.presentedViewController {
            presenetedVC = pVC
        }
        
        if presenetedVC == nil {
            print("BBAlertView Error : don't have a view")
        }
        return presenetedVC
    }
    
    public class func alert(title: String) -> UIAlertController {
        return alert(title, message: "")
    }
    
    public class func alert(title: String, message: String) -> UIAlertController {
        return alert(title, message: message, acceptMessage: "OK") { () -> () in
        }
    }
    
    public class func alert(title: String, message: String, acceptMessage: String, acceptBlock : () -> ()) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let acceptButton = UIAlertAction(title: acceptMessage, style: .Default, handler: {(action: UIAlertAction) in
            acceptBlock()
        })
        alert.addAction(acceptButton)
        
        instance.topMostController()?.presentViewController(alert, animated: true, completion: nil)
        return alert
    }
    
    public class func alert(title: String, message: String, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert, buttons: buttons, tapBlock: tapBlock!)
        instance.topMostController()?.presentViewController(alert, animated: true, completion: nil)
        return alert
    }

    public class func actionSheet(title: String, message: String, sourceView: UIView, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        for action in actions {
            alert.addAction(action)
        }
        alert.popoverPresentationController?.sourceView = sourceView
        alert.popoverPresentationController?.sourceRect = sourceView.bounds
        instance.topMostController()?.presentViewController(alert, animated: true, completion: nil)
        return alert
    }
    
    public class func actionSheet(title: String, message: String, sourceView: UIView, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert, buttons: buttons, tapBlock: tapBlock!)
        alert.popoverPresentationController?.sourceView = sourceView
        alert.popoverPresentationController?.sourceRect = sourceView.bounds
        instance.topMostController()?.presentViewController(alert, animated: true, completion: nil)
        return alert
    }
}

private extension UIAlertController {
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, buttons: [String], tapBlock: ((UIAlertAction, Int) -> Void)?) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        var buttonIndex = 0
        for buttonTitle in buttons {
            let action = UIAlertAction(title: buttonTitle, preferredStyle: UIAlertActionStyle.Default, buttonIndex: buttonIndex, tapBlock: tapBlock)
            buttonIndex += 1
            self.addAction(action)
        }
    }
}

private extension UIAlertAction {
    convenience init(title: String?, preferredStyle: UIAlertActionStyle, buttonIndex:Int, tapBlock:((UIAlertAction,Int) -> Void)?) {
        self.init(title: title, style: style) {
            (action:UIAlertAction) in
            if let block = tapBlock {
                block(action,buttonIndex)
            }
        }
    }
}