//
//  KeywordCollectionViewCell.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 29..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var content: UIButton!
    
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var commentNum: UILabel!
    
    @IBOutlet weak var keywordFirst: UIButton!

    @IBOutlet weak var keywordSecond: UIButton!
    
    @IBOutlet weak var keywordThird: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var likeImage: UIButton!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.addTarget(self, action: "aa", forControlEvents: .TouchUpInside)
        // Initialization code
    }
//    override var selected: Bool {
//        
//        get {
//            likeImage.addTarget(self, action: "aa", forControlEvents: .TouchUpInside)
//
//            return super.selected
//        }
//        set {
//            likeImage.addTarget(self, action: "aa", forControlEvents: .TouchUpInside)
//            if newValue {
//                likeImage.addTarget(self, action: "aa", forControlEvents: .TouchUpInside)
//                super.selected = true
//                print("selected")
//            } else if newValue == false {
//                super.selected = false
//                print("deselected")
//            }
//        }
//    }
    func aa() {
        print("Xx")
        let image = UIImage(named: "like")
        let image2 = UIImage(named: "unlike")
        
        if likeImage.imageView?.image == image2 {
            likeImage.setImage(image, forState: .Normal)
            var tmp = Int(likeNum.text!)
            tmp! = tmp! + 1
            likeNum.text = "\(tmp!)"
        } else {
            likeImage.setImage(image2, forState: .Normal)
            var tmp = Int(likeNum.text!)
            tmp! = tmp! - 1
            likeNum.text = "\(tmp!)"            
        }

    }
    
}
