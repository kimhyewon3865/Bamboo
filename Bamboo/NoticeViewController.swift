//
//  NoticeViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 2. 19..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func closeButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension NoticeViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = noticeTableView.dequeueReusableCellWithIdentifier("noticeCell", forIndexPath: indexPath) as! NoticeTableViewCell
        
        return cell
    }
}
