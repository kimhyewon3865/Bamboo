//
//  NoticeTableViewCell.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 2. 19..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var megaphoneImaveView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
