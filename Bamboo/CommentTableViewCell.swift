//
//  CommentTableViewCell.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 1. 2..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!

    @IBOutlet weak var commentContent: UILabel!
    
    @IBOutlet weak var commnetLikeNum: UILabel!
    
    @IBAction func likeBtn(sender: AnyObject) {
    }
}
