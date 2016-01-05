//
//  PostBoardCameraViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 30..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class PostBoardCameraViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var navBarButton: UIButton!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    var isNavBarNextButton = false
    var capturedPhoto: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TGCamera.setOption(kTGCameraOptionSaveImageToAlbum, value: true)
        placeHolderLabel.hidden = true
    }
    
    func changeNavBarButton() {
        if self.photoImageView.image == nil {
            return
        } else {
            placeHolderLabel.hidden = false
            isNavBarNextButton = true
            navBarButton.setImage(UIImage(named: "next"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func rollButtonClicked(sender: UIButton) {
        let navigationController = TGCameraNavigationController.newWithCameraDelegate(self)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func navBarButtonClicked(sender: UIButton) {
        if photoImageView.image == nil {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "SavePhoto" {
            if isNavBarNextButton {
                return true
            } else {
            }
        }
        return false
    }
}

extension PostBoardCameraViewController: TGCameraDelegate {
    func cameraDidCancel() {
        self.changeNavBarButton()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidTakePhoto(image: UIImage!) {
        photoImageView.image = image
        self.capturedPhoto = image
        self.changeNavBarButton()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        photoImageView.image = image
        self.capturedPhoto = image
        self.changeNavBarButton()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
