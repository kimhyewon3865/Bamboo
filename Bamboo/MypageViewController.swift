//
//  MypageViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 26..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class MypageViewController: UIViewController {
    
    @IBOutlet weak var myPageTableView: UITableView!
    @IBOutlet weak var univLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    var myPages = [MyPage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMypageVC()
        setDisplayData()
    }
    
    func setMypageVC() {
        self.pointLabel.text = "\(User.sharedInstance().point)"
        self.univLabel.text = "\(User.sharedInstance().univ)"
    }
    
    func setDisplayData() {
        Alamofire
            .request(Router.GetMyPage(uuid: "\(User.sharedInstance().uuid)", type: "T01"))
            .responseCollection { (response: Response<[MyPage], NSError>) in
                if response.result.isSuccess {
                    BBActivityIndicatorView.show("AAA")
                    self.myPages = (response.result.value)!
                    self.myPageTableView.reloadData()
                } else {}
        }
    }
}

extension MypageViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myPageTableView.dequeueReusableCellWithIdentifier("MyPageCell", forIndexPath: indexPath) as! MyPageTableViewCell
        
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = UIColor.whiteColor()
//        } else {
//            cell.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
//        }
        
        cell.dateLabel.text = self.myPages[indexPath.row].date
        cell.dayLabel.text = self.myPages[indexPath.row].day
        cell.timeLabel.text = self.myPages[indexPath.row].time
        cell.typeLabel.text = self.myPages[indexPath.row].type
        cell.contentsLabel.text = self.myPages[indexPath.row].contents
        cell.likeCntLabel.text = self.myPages[indexPath.row].likeCnt
        cell.commentCntLabel.text = self.myPages[indexPath.row].commentCnt
        if self.myPages[indexPath.row].isNotice == "N" {
            cell.noticeButton.hidden = true
        }
        return cell
    }
}

