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

    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        likeBtn.addTarget(self, action: "commentLikeFunc", forControlEvents: .TouchUpInside)
        
        // Configure the view for the selected state
    }

    func commentLikeFunc() {
        let image = UIImage(named: "like")
        let image2 = UIImage(named: "unlike")
        
        if likeBtn.imageView?.image == image2 {
            likeBtn.setImage(image, forState: .Normal)
            var tmp = Int(commnetLikeNum.text!)
            tmp! = tmp! + 1
            commnetLikeNum.text = "\(tmp!)"
        } else {
            likeBtn.setImage(image2, forState: .Normal)
            var tmp = Int(commnetLikeNum.text!)
            tmp! = tmp! - 1
            commnetLikeNum.text = "\(tmp!)"
            
        }
    }

}
