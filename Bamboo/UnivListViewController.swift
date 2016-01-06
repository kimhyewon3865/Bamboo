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
    var plusUnivBoards : [UnivBoard] = []
    var refreshControl:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
        initUnivBoard()
        
//        self.btnBest.hidden = true
//        self.btnNew.hidden = true
//        btnBest.addTarget(self, action: "btnBestFunc", forControlEvents: .TouchUpInside)
//        btnNew.addTarget(self, action: "btnNewFunc", forControlEvents: .TouchUpInside)
//        btnWrite.addTarget(self, action: "btnWriteFunc", forControlEvents: .TouchUpInside)
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
//        self.univListTableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }

    func refresh(sender:AnyObject)
    {
        initUnivBoard()
        pageInt = 1
        print("refresh")
        self.refreshControl?.endRefreshing()
        // Code to refresh table view
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
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item > 4 {
        if indexPath.item == (univBoards.count-1) {
            pageInt = pageInt + 1
            print(pageInt)
            plusInitUnivBoard()
        }
        }
    }
    
    var pageInt = 1

    func initSetting() {
        self.univListTableView.delegate = self
        self.univListTableView.dataSource = self
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        btnBest.addTarget(self, action: "btnBestFunc", forControlEvents: .TouchUpInside)
        btnNew.addTarget(self, action: "btnNewFunc", forControlEvents: .TouchUpInside)
        btnWrite.addTarget(self, action: "btnWriteFunc", forControlEvents: .TouchUpInside)
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.univListTableView.addSubview(refreshControl)
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
    
    func plusInitUnivBoard() {
        Alamofire
            .request(Router.GetList(type: "T03", page: "\(pageInt)", university: "가천대학교"))
            .responseCollection { (response: Response<[UnivBoard], NSError>) in
                if response.result.isSuccess {
                    self.univBoards = response.result.value!
                    print(response)
                    print(response.result.value)
                    self.univBoards = self.univBoards + self.plusUnivBoards

                }
                
                self.univListTableView.reloadData()
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUnivDetail" {
            let DetailVC = segue.destinationViewController as! DetailViewController
            
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:univListTableView)
            let indexPath = univListTableView.indexPathForItemAtPoint(point)
            
            DetailVC.contentT = univBoards[indexPath!.row].contents
            DetailVC.keywords = univBoards[indexPath!.row].keywords
            DetailVC.contentlikeNumT = String(univBoards[indexPath!.row].numberOfLike)
            DetailVC.commentNumT = String(univBoards[indexPath!.row].numberOfComment)

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
    @IBOutlet weak var btnWrite: UIButton!
    
    func btnWriteFunc() {
        self.btnBest.hidden = false
        self.btnNew.hidden = false
        let image  = UIImage(named: "btn_write_unselected")
        btnWrite.setImage(image, forState: .Normal)
    }
    
    @IBOutlet weak var btnBest: UIButton!
    
    
    
    func btnBestFunc() {
        print(123)
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        let image  = UIImage(named: "btn_best_selected")
        let image2  = UIImage(named: "btn_new_unselected")
        btnWrite.setImage(image, forState: .Normal)
        btnBest.setImage(image, forState: .Normal)
        btnNew.setImage(image2, forState: .Normal)
    }
    
    @IBOutlet weak var btnNew: UIButton!
    
    func btnNewFunc() {
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        let image  = UIImage(named: "btn_new_selected")
        let image2  = UIImage(named: "btn_best_unselected")
        btnWrite.setImage(image, forState: .Normal)
        btnNew.setImage(image, forState: .Normal)
        btnBest.setImage(image2, forState: .Normal)
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
