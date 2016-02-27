//
//  ViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 14..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class GeneralListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var generalListTableView: UICollectionView!
    
    @IBOutlet weak var generalListTableView: UITableView!
    
    var generalBoards = [GeneralBoard]()
    var plusGeneralBoards = [GeneralBoard]()
    
    var refreshControl:UIRefreshControl!
    
    var isAnimating = false
    
    var likeTempN = 0
    var type = "T01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGeneralBoard()
        initSetting()
    }
    
    override func viewWillAppear(animated: Bool) {
        pageInt = 1
        initGeneralBoard()
        initSetting()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "catchIt:", name: "myNotif", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func refresh(sender:AnyObject)
    {
        pageInt = 1
        print("refresh")
        if refreshControl.refreshing {
            if isAnimating {
                print(refreshControl.refreshing)
                self.refreshControl?.endRefreshing()
                isAnimating = false
            }
        }
        self.refreshControl?.endRefreshing()
        
        //initSetting()
        initGeneralBoard()
        
        // Code to refresh table view
    }
    var countN = 0
    
    func initSetting() {
        self.generalListTableView.delegate = self
        self.generalListTableView.dataSource = self
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        
        btnBest.addTarget(self, action: "btnBestFunc", forControlEvents: .TouchUpInside)
        btnNew.addTarget(self, action: "btnNewFunc", forControlEvents: .TouchUpInside)
        btnWrite.addTarget(self, action: "btnWriteFunc", forControlEvents: .TouchUpInside)
        if !isAnimating {
            isAnimating = true
            self.refreshControl = UIRefreshControl()
            self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            
            self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
            self.generalListTableView.addSubview(refreshControl)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print("indexPath")
        print(indexPath.item)
        print(generalBoards.count)
        if indexPath.item > 4 {
            if generalBoards.count == 20 *  pageInt {
                if indexPath.item == (generalBoards.count-1) {
                    print("last")
                    pageInt = pageInt + 1
                    print(pageInt)
                    plusInitGeneralBoard()
                }
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.generalBoards.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = generalListTableView.dequeueReusableCellWithIdentifier("generalTableCell", forIndexPath: indexPath) as! GeneralTableViewCell
        
        cell.contents.setTitle(self.generalBoards[indexPath.row].contents, forState: .Normal)
        
        cell.likeNum.text = String(self.generalBoards[indexPath.row].numberOfLike)
        
        cell.commentNum.text = String(self.generalBoards[indexPath.row].numberOfComment)
        
        if generalBoards[indexPath.row].imgURL != "" {
            print("url")
            cell.backgroundImage.hidden = false
            cell.backgroundImage.downloadedFrom(link: generalBoards[indexPath.row].imgURL, contentMode: .ScaleToFill)
            //cell.insertSubview(cell.backgroundImage, atIndex: indexPath.row)
            //            var imageView = UIImageView(frame: CGRectMake(0, 0, 375, cell.frame.height))
            //            imageView.image = cell.backgroundImage.image
            //            print(cell.frame.width)
            //            print(cell.backgroundImage.image?.size.width)
            
            
        }
        else {
            cell.backgroundImage.hidden = true
        }
        //cell.addSubview(cell.backgroundImage)
        //print(indexPath.row)
        
        //if generalBoards[indexPath.row].keywords != ""{
        
        print(generalBoards[indexPath.row].contents)
        print(generalBoards[indexPath.row].keywordArray.count)
        if(generalBoards[indexPath.row].keywordArray.count == 0){
            cell.keywordFirst.hidden = true
            cell.keywordSecond.hidden = true
            cell.keywordThird.hidden = true
            //                cell.keywordFirst.setTitle(" ", forState: .Normal)
            //                cell.keywordSecond.setTitle(" ", forState: .Normal)
            //                cell.keywordThird.setTitle(" ", forState: .Normal)
        }
        else if(generalBoards[indexPath.row].keywordArray.count == 1){
            cell.keywordFirst.hidden = false
            cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.hidden = true
            cell.keywordThird.hidden = true
            //                cell.keywordSecond.setTitle("", forState: .Normal)
            //                cell.keywordThird.setTitle("", forState: .Normal)
        }
        else if(generalBoards[indexPath.row].keywordArray.count == 2){
            cell.keywordFirst.hidden = false
            cell.keywordSecond.hidden = false
            cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[1], forState: .Normal)
            cell.keywordThird.hidden = true
        }
        else {
            cell.keywordFirst.hidden = false
            cell.keywordSecond.hidden = false
            cell.keywordThird.hidden = false
            cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[1], forState: .Normal)
            cell.keywordThird.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[2], forState: .Normal)
        }
        //}
        // print(univBoards[indexPath.row].keywordArray.count)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        }
        
        if generalBoards[indexPath.row].islike == "0" {
            let image: UIImage = UIImage(named: "unlike")!
            cell.likeImage.setImage(image, forState: UIControlState.Normal)
        } else {
            let image: UIImage = UIImage(named: "like")!
            cell.likeImage.setImage(image, forState: UIControlState.Normal)
        }
        
        cell.likeImage.addTarget(self, action: Selector("contentLikeFunc:"), forControlEvents: .TouchUpInside)
        
        
        return cell
    }
    
    func contentLikeFunc(sender: UIButton) {
        let point : CGPoint = sender.convertPoint(CGPointZero, toView:generalListTableView)
        let indexPath = generalListTableView.indexPathForRowAtPoint(point)
        let code = generalBoards[indexPath!.row].code
        
        Alamofire.request(Router.SetLike(uuid: User.sharedInstance().uuid, bCode: code))
    }
    
    var pageInt = 1
    
    func initGeneralBoard() {
        BBActivityIndicatorView.show("로딩중입니다><")
        Alamofire
            .request(Router.GetList(type: self.type, page: "1", university: User.sharedInstance().univ , uuid: User.sharedInstance().uuid))
            .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                if response.result.isSuccess {
                    BBActivityIndicatorView.hide()
                    self.generalBoards = response.result.value!
                    print(response)
                    print(response.result.value)
                }
                self.generalListTableView.reloadData()
        }
    }
    
    func plusInitGeneralBoard() {
        Alamofire
            .request(Router.GetList(type: self.type, page: "\(pageInt)", university: User.sharedInstance().univ, uuid: User.sharedInstance().uuid))
            .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                if response.result.isSuccess {
                    self.plusGeneralBoards = response.result.value!
                    print(response)
                    print(response.result.value)
                    
                    self.generalBoards = self.generalBoards + self.plusGeneralBoards
                }
                
                self.generalListTableView.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGeneralDetail" {
            let DetailVC = segue.destinationViewController as! DetailViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            DetailVC.contentT = generalBoards[indexPath!.row].contents
            DetailVC.keywords = generalBoards[indexPath!.row].keywords
            DetailVC.contentlikeNumT = String(generalBoards[indexPath!.row].numberOfLike)
            DetailVC.commentNumT = String(generalBoards[indexPath!.row].numberOfComment)
            DetailVC.code = generalBoards[indexPath!.row].code
            DetailVC.imageT = generalBoards[indexPath!.row].imgURL
            DetailVC.state = generalBoards[indexPath!.row].islike
        } else if segue.identifier == "keywordGeneralFirstSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[0]
        } else if segue.identifier == "keywordGeneralSecondSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[1]
        } else if segue.identifier == "keywordGeneralThirdSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[2]
        } else if segue.identifier == "generalPost" {
            let PostBoardVC = segue.destinationViewController as! PostBoardViewController
            PostBoardVC.type = "일반"
            
        }
        
        
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
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        let image  = UIImage(named: "btn_best_selected")
        let image2  = UIImage(named: "btn_new_unselected")
        btnWrite.setImage(image, forState: .Normal)
        btnBest.setImage(image, forState: .Normal)
        btnNew.setImage(image2, forState: .Normal)
        
        self.type = "T02"
        self.pageInt = 1
        initGeneralBoard()
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
        
        self.type = "T01"
        self.pageInt = 1
        initGeneralBoard()
    }
}

extension UIViewController {
    func catchIt(userInfo: NSNotification) {
        let descriptions = LibraryAPI.sharedInstance.pushNotificationTriggered()
        BBAlertView.alert(descriptions.title, message: descriptions.message, buttons: descriptions.buttons, tapBlock: {(alertAction, position) -> Void in
            if position == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let noticeVC = storyboard.instantiateViewControllerWithIdentifier("noticeVC") as! NoticeViewController
                //self.navigationController?.pushViewController(noticeVC, animated: true)
                self.presentViewController(noticeVC, animated: true, completion: nil)
            }
        })
    }
}

extension UIImageView {
    func downloadedFrom(link link:String, contentMode mode: UIViewContentMode) {
        guard
            let url = NSURL(string: link)
            else {return}
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
            }
        }).resume()
    }
}