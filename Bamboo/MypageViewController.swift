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
    @IBOutlet weak var hiddenView: UIView!
    
    var myPages = [MyPage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMypageVC()
        hiddenView.hidden = true
        setDisplayData()
    }
    
    override func viewWillAppear(animated: Bool) {
        setMypageVC()
        hiddenView.hidden = true
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
                //BBActivityIndicatorView.show("데이터를 불러오는 중입니다.")
                if response.result.isSuccess {
                    //BBActivityIndicatorView.hide()
                    self.myPages = (response.result.value)!
                    if self.myPages.isEmpty {
                        self.hiddenView.backgroundColor = UIColor.whiteColor()
                        self.hiddenView.hidden = false
                    }
                    self.myPageTableView.reloadData()
                } else {}
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectMyPageCell" {
            let detailVC = segue.destinationViewController as! DetailViewController
            
            let cell = sender as! UITableViewCell
            let indexPath = self.myPageTableView.indexPathForCell(cell)!
            
            detailVC.contentT = myPages[indexPath.row].contents
            detailVC.keywords = myPages[indexPath.row].keywords
            detailVC.contentlikeNumT = myPages[indexPath.row].likeCnt
            detailVC.commentNumT = myPages[indexPath.row].commentCnt
            detailVC.code = myPages[indexPath.row].code
        }
    }
}

extension MypageViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myPageTableView.dequeueReusableCellWithIdentifier("MyPageCell", forIndexPath: indexPath) as! MyPageTableViewCell
        
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

