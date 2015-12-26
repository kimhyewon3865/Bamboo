//
//  MainTabBarController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 26..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    @IBOutlet var mainTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTabBar.tintColor = UIColor(red: 74/255, green: 135/255, blue: 69/255, alpha: 1)

        let tabItems = self.tabBar.items! as [UITabBarItem]
        tabItems[2].image = (UIImage(named: "tab_mypage_unselected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        tabItems[2].selectedImage = (UIImage(named: "tab_mypage_selected"))?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}
