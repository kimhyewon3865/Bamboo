//
//  NoticeViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 2. 19..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let cell = generalListTableView.dequeueReusableCellWithIdentifier("generalTableCell", forIndexPath: indexPath) as! GeneralTableViewCell

        let cell = noticeTableView.dequeueReusableCellWithIdentifier("noticeCell", forIndexPath: indexPath) as! NoticeTableViewCell
        
        return cell
    }

    @IBAction func closeButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
