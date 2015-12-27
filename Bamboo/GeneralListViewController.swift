//
//  ViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 14..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class GeneralListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var generalBoards = [GeneralBoard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

extension GeneralListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.generalBoards.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as! ListTableViewCell
        
        cell.codeLabel.text = generalBoards[indexPath.row].contents
        return cell
    }
}

extension GeneralListViewController: UITableViewDelegate {
    
}

