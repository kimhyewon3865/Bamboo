//
//  ViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 14..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class GeneralListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var generalListTableView: UICollectionView!
    
    var generalBoards = [GeneralBoard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generalListTableView.delegate = self
        self.generalListTableView.dataSource = self
        initGeneralBoard()
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.generalBoards.count
    }

    // MARK: - CollectionView DataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("generalCell", forIndexPath: indexPath) as! GeneralCollectionViewCell
        
        cell.contents.setTitle(self.generalBoards[indexPath.row].contents, forState: .Normal)
        
        cell.likeNum.text = String(self.generalBoards[indexPath.row].numberOfLike)
        
        cell.commentNum.text = String(self.generalBoards[indexPath.row].numberOfComment)
        
        //print(indexPath.row)
        
        //if generalBoards[indexPath.row].keywords != ""{
            if(generalBoards[indexPath.row].keywordArray.count == 0){
                cell.keywordFirst.hidden = true
                cell.keywordSecond.hidden = true
                cell.keywordThird.hidden = true
                //                cell.keywordFirst.setTitle(" ", forState: .Normal)
                //                cell.keywordSecond.setTitle(" ", forState: .Normal)
                //                cell.keywordThird.setTitle(" ", forState: .Normal)
            }
            else if(generalBoards[indexPath.row].keywordArray.count == 1){
                cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
                cell.keywordSecond.hidden = true
                cell.keywordThird.hidden = true
                //                cell.keywordSecond.setTitle("", forState: .Normal)
                //                cell.keywordThird.setTitle("", forState: .Normal)
            }
            else if(generalBoards[indexPath.row].keywordArray.count == 2){
                cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
                cell.keywordSecond.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[1], forState: .Normal)
                cell.keywordThird.setTitle("", forState: .Normal)
            }
            else {
                cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
                cell.keywordSecond.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[1], forState: .Normal)
                cell.keywordThird.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[2], forState: .Normal)
            }
        //}
        // print(univBoards[indexPath.row].keywordArray.count)
        
        
        return cell
    }
    
    func initGeneralBoard() {
        Alamofire
            .request(Router.GetList(type: "T01", page: "1", university: "가천대학교"))
            .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                if response.result.isSuccess {
                    self.generalBoards = response.result.value!
                    print(response)
                    print(response.result.value)
                }
                
                self.generalListTableView.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGeneralDetail" {
            let DetailVC = segue.destinationViewController as! DetailViewController
            
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForItemAtPoint(point)
            
            DetailVC.code = generalBoards[indexPath!.row].code
            print(DetailVC.code)
        }
            
        else if segue.identifier == "keywordGeneralFirstSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForItemAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[0]
        }
            
        else if segue.identifier == "keywordGeneralSecondSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForItemAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[1]
        }
        else if segue.identifier == "keywordGeneralThirdSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForItemAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[2]
        }

        
    }
}
//
//extension GeneralListViewController: UITableViewDataSource {
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.generalBoards.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = listTableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as! ListTableViewCell
//        
//        cell.codeLabel.text = generalBoards[indexPath.row].contents
//        return cell
//    }
//}
//
//extension GeneralListViewController: UITableViewDelegate {
//    
//}
//
