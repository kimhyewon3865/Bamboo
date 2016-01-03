//
//  PostBoardCameraViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 30..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class PostBoardCameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = TGCameraNavigationController.newWithCameraDelegate(self)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension PostBoardCameraViewController: TGCameraDelegate {
    func cameraDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidTakePhoto(image: UIImage!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
