//
//  UnivListCollectionViewCell.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 23..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class UnivListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contents: UIButton!
    
    @IBOutlet weak var likeNum: UILabel!
    
    @IBOutlet weak var commentNum: UILabel!
    
    @IBOutlet weak var keywordFirst: UIButton!

    @IBOutlet weak var keywordSecond: UIButton!
    @IBOutlet weak var keywordThird: UIButton!
    
    @IBOutlet weak var likeImage: UIImageView!
    
}
