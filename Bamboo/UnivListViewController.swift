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
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.univBoards.count
    }
    

    // MARK: - TableView DataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("univListCell", forIndexPath: indexPath) as! UnivListCollectionViewCell
        
        cell.contents.setTitle(self.univBoards[indexPath.row].contents, forState: .Normal)
        
        cell.likeNum.text = String(self.univBoards[indexPath.row].numberOfLike)
        
        cell.commentNum.text = String(self.univBoards[indexPath.row].numberOfComment)
        
        //print(indexPath.row)
        
        if univBoards[indexPath.row].keywords != ""{
            if(univBoards[indexPath.row].keywordArray.count == 0){
                cell.keywordFirst.hidden = true
                cell.keywordSecond.hidden = true
                cell.keywordThird.hidden = true
//                cell.keywordFirst.setTitle(" ", forState: .Normal)
//                cell.keywordSecond.setTitle(" ", forState: .Normal)
//                cell.keywordThird.setTitle(" ", forState: .Normal)
            }
            else if(univBoards[indexPath.row].keywordArray.count == 1){
                cell.keywordFirst.setTitle("#"+self.univBoards[indexPath.row].keywordArray[0], forState: .Normal)
                cell.keywordSecond.hidden = true
                cell.keywordThird.hidden = true
//                cell.keywordSecond.setTitle("", forState: .Normal)
//                cell.keywordThird.setTitle("", forState: .Normal)
            }
            else if(univBoards[indexPath.row].keywordArray.count == 2){
                cell.keywordFirst.setTitle("#"+self.univBoards[indexPath.row].keywordArray[0], forState: .Normal)
                cell.keywordSecond.setTitle("#"+self.univBoards[indexPath.row].keywordArray[1], forState: .Normal)
                cell.keywordThird.setTitle("", forState: .Normal)
            }
            else {
                cell.keywordFirst.setTitle("#"+self.univBoards[indexPath.row].keywordArray[0], forState: .Normal)
                cell.keywordSecond.setTitle("#"+self.univBoards[indexPath.row].keywordArray[1], forState: .Normal)
                cell.keywordThird.setTitle("#"+self.univBoards[indexPath.row].keywordArray[2], forState: .Normal)
            }
        }
        //print(univBoards[indexPath.row].keywordArray.count)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        }

        
        return cell
    }
    
    func initSetting() {
        self.univListTableView.delegate = self
        self.univListTableView.dataSource = self
    }
    
    func initUnivBoard() {
        Alamofire
            .request(Router.GetList(type: "T03", page: "1", university: "가천대학교"))
            .responseCollection { (response: Response<[UnivBoard], NSError>) in
                if response.result.isSuccess {
                    self.univBoards = response.result.value!
                    print(response)
                    print(response.result.value)
                }
                
                self.univListTableView.reloadData()
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUnivDetail" {
            let DetailVC = segue.destinationViewController as! DetailViewController
            
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:univListTableView)
            let indexPath = univListTableView.indexPathForItemAtPoint(point)

            DetailVC.code = univBoards[indexPath!.row].code
            print(DetailVC.code)
        }
        else if segue.identifier == "keywordUnivFirstSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:univListTableView)
            let indexPath = univListTableView.indexPathForItemAtPoint(point)
            
            KeywordVC.titleName = univBoards[indexPath!.row].keywordArray[0]
        }
        
        else if segue.identifier == "keywordUnivSecondSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:univListTableView)
            let indexPath = univListTableView.indexPathForItemAtPoint(point)
            
            KeywordVC.titleName = univBoards[indexPath!.row].keywordArray[1]
        }
        else if segue.identifier == "keywordUnivThirdSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:univListTableView)
            let indexPath = univListTableView.indexPathForItemAtPoint(point)
            
            KeywordVC.titleName = univBoards[indexPath!.row].keywordArray[2]
        }
        else if segue.identifier == "univPost" {
            let PostBoardVC = segue.destinationViewController as! PostBoardViewController
            PostBoardVC.type = User.sharedInstance().univ
        
        }


    }

    
    @IBAction func cancelToListVC(segue : UIStoryboardSegue) {
        
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
