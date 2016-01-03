//
//  GeneralCollectionViewCell.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 1. 2..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class GeneralCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contents: UIButton!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var commentNum: UILabel!
    
    @IBOutlet weak var keywordFirst: UIButton!
    
    @IBOutlet weak var keywordSecond: UIButton!
    
    @IBOutlet weak var keywordThird: UIButton!
    @IBOutlet weak var likeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }

}
