//
//  PostBoardViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 28..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class PostBoardViewController: UIViewController {
    
    //사진 imageView
    @IBOutlet weak var photoImageView: UIImageView!
    //게시글 TextView
    @IBOutlet weak var contentsTextView: UITextView!
    //"속마음을 표현해보세요" 레이블
    @IBOutlet weak var placeHolderLabel: UILabel!
    //키보드 위 사진및 확성기 게시기능을 할수 있는 View
    @IBOutlet weak var toolBoxView: UIView!
    //툴박스 확성기 버튼
    @IBOutlet weak var toolBoxNoticeButton: UIButton!
    //네비게이션 아이템
    @IBOutlet weak var postNavigationItem: UINavigationItem!
    @IBOutlet weak var containerImageView: UIImageView!
    @IBOutlet weak var smileImageView: UIImageView!
    
    //게시글 내용
    var contents: String = ""
    //페이지가 처음 로드되는지 판단
    var isFirstLoaded = true
    //일반글또는 대학글에서 누루는지 판단
    var type = ""
    //확성기 활성화 여부
    var isNotiveActivate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        settingToolBoxNoticeButton()
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
    
    func settingNavigationItem() {
        self.postNavigationItem.title = self.type
    }
    
    func settingToolBoxNoticeButton() {
        if self.type == "일반" {
            self.toolBoxNoticeButton.hidden = true
        }
    }
    
    func keyWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.toolBoxView.frame = CGRectMake(toolBoxView.frame.origin.x, toolBoxView.frame.origin.y + (keyboardSize.size.height * -1), toolBoxView.frame.size.width, toolBoxView.frame.size.height)
            }
        }
    }
    
    func setImageToPhotoImageView(image: UIImage) {
        self.containerImageView.hidden = true
        self.smileImageView.hidden = true
        self.photoImageView.image = image
    }
    
    func setPoint() {
        Alamofire
            .request(Router.SetPoint(uuid: User.sharedInstance().uuid))
    }
    
    func setPointReturn() {
        Alamofire
            .request(Router.SetPointReturn(uuid: User.sharedInstance().uuid))
    }
    
    func setUser() {
        let jsonParser = SimpleJsonParser()
        jsonParser.HTTPGetJson("http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Get_MyInfo.php?uuid=\(User.sharedInstance().uuid)") {
            (data : Dictionary<String, AnyObject>, error : String?) -> Void in
            if error != nil {
                print("\(error) : PostBoardVC")
            } else {
                if let uuid = data["m_uuid"] as? String,
                    let point = data["m_point"] as? String,
                    let univ = data["m_univ"] as? String {
                        User.sharedInstance().uuid = uuid
                        User.sharedInstance().point = point
                        User.sharedInstance().univ = univ
                } else {
                    //print("User객체 SimpleJsonParser인스턴스 failed")
                }
            }
        }
        sleep(1)
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
        if isNotiveActivate == false {
            NSNotificationCenter.defaultCenter().removeObserver(self)
            let descriptions = LibraryAPI.sharedInstance.clickNoticeButton(point: User.sharedInstance().point)
            BBAlertView.alert(descriptions.title, message: descriptions.message, buttons: descriptions.buttons, tapBlock: {(alertAction, position) -> Void in
                if position == 1 {
                    if Int(User.sharedInstance().point) < 10 {
                        let descriptions = LibraryAPI.sharedInstance.ifLessPointThan10()
                        BBAlertView.alert(descriptions.title, message: descriptions.message)
                    } else {
                        self.isNotiveActivate = true
                        self.toolBoxNoticeButton.setImage(UIImage(named: "notive_active"), forState: UIControlState.Normal)
                        self.setPoint()
                        self.setUser()
                    }
                }
            })
        } else {
            self.isNotiveActivate = false
            self.toolBoxNoticeButton.setImage(UIImage(named: "keyboard_notice"), forState: UIControlState.Normal)
            self.setPointReturn()
            self.setUser()
        }
    }
    
    @IBAction func toolBoxPostButtonClicked(sender: UIButton) {
    }
    
    @IBAction func savePhotoFromPostBoardAlbumVC(segue: UIStoryboardSegue) {
        let postBoardAlbumVC = segue.sourceViewController as! PostBoardAlbumViewController
        setImageToPhotoImageView(postBoardAlbumVC.selectedPhoto!)
    }
    
    @IBAction func savePhotoFromPostBoardCameraVC(segue: UIStoryboardSegue) {
        let postBoardCameraVC = segue.sourceViewController as! PostBoardCameraViewController
        
        if let photoImage = postBoardCameraVC.capturedPhoto {
            setImageToPhotoImageView(photoImage)
        }
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