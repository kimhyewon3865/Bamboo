//
//  PostBoardViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 28..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class PostBoardViewController: UIViewController {
    
    //게시글 TextView
    @IBOutlet weak var contentsTextView: UITextView!
    //"속마음을 표현해보세요" 레이블
    @IBOutlet weak var placeHolderLabel: UILabel!
    //키보드 위 사진및 확성기 게시기능을 할수 있는 View
    @IBOutlet weak var toolBoxView: UIView!
    //툴박스 확성기 버튼
    @IBOutlet weak var toolBoxNoticeButton: UIButton!
    
    //게시글 내용
    var contents: String = ""
    var isFirstLoaded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingContentsTextView()
    }
    
    override func viewWillAppear(animated: Bool) {
        contentsTextView.becomeFirstResponder()
    }

    // MARK: - Custom function
    func settingContentsTextView() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyWillShow:"), name: UIKeyboardDidShowNotification, object: nil)
        contentsTextView.becomeFirstResponder()
        contentsTextView.autocorrectionType = .No
    }
    
    func keyWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.toolBoxView.frame = CGRectMake(toolBoxView.frame.origin.x, toolBoxView.frame.origin.y + (keyboardSize.size.height * -1), toolBoxView.frame.size.width, toolBoxView.frame.size.height)
            }
        }
    }
    
    // MARK: - IBAction function
    @IBAction func closeButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func toolBoxCameraButtonClicked(sender: UIButton) {
        self.isFirstLoaded = false
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func toolBoxNoticeButtonClicked(sender: UIButton) {
    }
    
    @IBAction func toolBoxPostButtonClicked(sender: UIButton) {
        
    }
}

extension PostBoardViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {

        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        contents = contentsTextView.text
        if contents != "" {
            placeHolderLabel.hidden = true
        } else {
            placeHolderLabel.hidden = false
        }
    }
}