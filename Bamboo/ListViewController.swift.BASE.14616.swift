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
        
        cell.codeLabel.text = generalBoards[indexPath.row].code
        return cell
    }
    
    // MARK: - General Function
    func initSetting() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }
    
    func initGeneralBoards() {
        Alamofire
            .request(.GET, "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Get_List.php", parameters:["type" : "T01", "page" : "1", "university" : "가천대학교"])
            .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                if response.result.isSuccess {
                    self.generalBoards = response.result.value!
                }
                self.listTableView.reloadData()
        }
    }
}

