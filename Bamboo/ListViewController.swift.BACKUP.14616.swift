//
//  ViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 14..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var listTableView: UITableView!
    
    var generalBoards: [GeneralBoard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        initGeneralBoards()
    }
    
    // MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.generalBoards.count
    }
    
    // MARK: - TableView Delegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as! ListTableViewCell
        
<<<<<<< HEAD
        cell.codeLabel.text = generalBoards[indexPath.row].keywords
=======
        cell.codeLabel.text = generalBoards[indexPath.row].code // generalBoards[indexPath.row].__
>>>>>>> f8adcbf41127f8a47ca4a5c610d98f019a39f12d
        return cell
    }
    
    // MARK: - General Function
    func initSetting() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }
    
    func initGeneralBoards() {
        Alamofire
            .request(.GET, "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Get_List.php", parameters:["type" : "T01", "page" : "1", "university" : User.sharedInstance().univ])
            .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                if response.result.isSuccess {
                    self.generalBoards = response.result.value!
                }
                self.listTableView.reloadData()
        }
    }
}

