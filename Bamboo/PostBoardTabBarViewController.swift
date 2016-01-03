//
//  PostBoardTabBarViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 30..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class PostBoardTabBarViewController: UITabBarController {

    @IBOutlet weak var postBoardTapBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabItems = self.postBoardTapBar.items! as [UITabBarItem]
        tabItems[0].image = (UIImage(named: "tab_album_unselected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabItems[0].selectedImage = (UIImage(named: "tab_album_selected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabItems[1].image = (UIImage(named: "tab_photo_unselected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabItems[1].selectedImage = (UIImage(named: "tab_photo_selected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabItems[2].image = (UIImage(named: "tab_video_unselected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabItems[2].selectedImage = (UIImage(named: "tab_video_selected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}
