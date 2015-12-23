//
//  UnivListViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 23..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class UnivListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var univListTableView: UICollectionView!
    
    var univBoards : [UnivBoard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
        initUnivBoard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - TableView DataSource
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.univBoards.count
    }
    

    // MARK: - TableView DataSource
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("univListCell", forIndexPath: indexPath) as! UnivListCollectionViewCell
        cell.contents.setTitle(self.univBoards[indexPath.row].contents, forState: .Normal)
        cell.likeNum.text = String(self.univBoards[indexPath.row].numberOfLike)
        cell.commentNum.text = String(self.univBoards[indexPath.row].numberOfComment)
        
        
        return cell
    }
    
    func initSetting() {
        self.univListTableView.delegate = self
        self.univListTableView.dataSource = self
    }
    
    func initUnivBoard() {
        Alamofire
            .request(.GET, "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Get_List.php", parameters:["type" : "T01", "page" : "1", "university" : "가천대학교"])
            .responseCollection { (response: Response<[UnivBoard], NSError>) in
                if response.result.isSuccess {
                    self.univBoards = response.result.value!
                }
                
                self.univListTableView.reloadData()
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
