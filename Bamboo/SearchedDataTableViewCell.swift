//
//  SearchedDataTableViewCell.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 2. 18..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class SearchedDataTableViewCell: UITableViewCell {

    @IBOutlet weak var keywordNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
