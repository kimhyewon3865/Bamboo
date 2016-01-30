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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGeneralBoard()
        initSetting()
    }
    
    override func viewWillAppear(animated: Bool) {
        initGeneralBoard()
        initSetting()
    }
    
    func refresh(sender:AnyObject)
    {
        initGeneralBoard()
        pageInt = 1
        print("refresh")
        self.refreshControl?.endRefreshing()
        // Code to refresh table view
    }
    
    func initSetting() {
        self.generalListTableView.delegate = self
        self.generalListTableView.dataSource = self
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        
        btnBest.addTarget(self, action: "btnBestFunc", forControlEvents: .TouchUpInside)
        btnNew.addTarget(self, action: "btnNewFunc", forControlEvents: .TouchUpInside)
        btnWrite.addTarget(self, action: "btnWriteFunc", forControlEvents: .TouchUpInside)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.generalListTableView.addSubview(refreshControl)
        
    }
    
    // MARK: - CollectionView DataSource
    //    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //
    //        return self.generalBoards.count
    //    }
    
    // MARK: - CollectionView DataSource
    //    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("generalCell", forIndexPath: indexPath) as! GeneralCollectionViewCell
    //
    //        cell.contents.setTitle(self.generalBoards[indexPath.row].contents, forState: .Normal)
    //
    //        cell.likeNum.text = String(self.generalBoards[indexPath.row].numberOfLike)
    //
    //        cell.commentNum.text = String(self.generalBoards[indexPath.row].numberOfComment)
    //
    //        //print(indexPath.row)
    //
    //        //if generalBoards[indexPath.row].keywords != ""{
    //        if(generalBoards[indexPath.row].keywordArray.count == 0){
    //            cell.keywordFirst.hidden = true
    //            cell.keywordSecond.hidden = true
    //            cell.keywordThird.hidden = true
    //            //                cell.keywordFirst.setTitle(" ", forState: .Normal)
    //            //                cell.keywordSecond.setTitle(" ", forState: .Normal)
    //            //                cell.keywordThird.setTitle(" ", forState: .Normal)
    //        }
    //        else if(generalBoards[indexPath.row].keywordArray.count == 1){
    //            cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
    //            cell.keywordSecond.hidden = true
    //            cell.keywordThird.hidden = true
    //            //                cell.keywordSecond.setTitle("", forState: .Normal)
    //            //                cell.keywordThird.setTitle("", forState: .Normal)
    //        }
    //        else if(generalBoards[indexPath.row].keywordArray.count == 2){
    //            cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
    //            cell.keywordSecond.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[1], forState: .Normal)
    //            cell.keywordThird.setTitle("", forState: .Normal)
    //        }
    //        else {
    //            cell.keywordFirst.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[0], forState: .Normal)
    //            cell.keywordSecond.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[1], forState: .Normal)
    //            cell.keywordThird.setTitle("#"+self.generalBoards[indexPath.row].keywordArray[2], forState: .Normal)
    //        }
    //        //}
    //        // print(univBoards[indexPath.row].keywordArray.count)
    //        if indexPath.row % 2 == 0 {
    //            cell.backgroundColor = UIColor.whiteColor()
    //        } else {
    //            cell.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    //        }
    //
    //
    //        return cell
    //    }
    //
    //    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    //        if indexPath.item > 4 {
    //            if indexPath.item == (generalBoards.count-1) {
    //                print("last")
    //                pageInt = pageInt + 1
    //                print(pageInt)
    //                plusInitGeneralBoard()
    //            }
    //        }
    //    }
    //
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item > 4 {
            if indexPath.item == (generalBoards.count-1) {
                print("last")
                pageInt = pageInt + 1
                print(pageInt)
                plusInitGeneralBoard()
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
        cell.backgroundImage.downloadedFrom(link: generalBoards[indexPath.row].imgURL, contentMode: .ScaleAspectFit)
        //cell.insertSubview(cell.backgroundImage, atIndex: indexPath.row)
            var imageView = UIImageView(frame: CGRectMake(0, 0, 375, cell.frame.height))
            imageView.image = cell.backgroundImage.image
            print(cell.frame.width)
            print(cell.backgroundImage.image?.size.width)
            
            
            //cell.addSubview(cell.backgroundImage)
        }
        //cell.addSubview(cell.backgroundImage)
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
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        }
        
        cell.likeImage.addTarget(self, action: "contentLikeFunc", forControlEvents: .TouchUpInside)
        
        
        return cell
    }
    
    func contentLikeFunc() {
        print("왜왜")
        setLike()
//        contentLikeNum.text = String(contentLikeNumTmp)
    }
    
    func setLike() {
        let point : CGPoint = generalListTableView.convertPoint(CGPointZero, toView:generalListTableView)
        let indexPath = generalListTableView.indexPathForRowAtPoint(point)
        var code = generalBoards[indexPath!.row].code
        
        let jsonParser = SimpleJsonParser()
        jsonParser.HTTPGetJson("http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Set_Like.php?b_code=\(code)&uuid=\(User.sharedInstance().uuid)") {
            (data : Dictionary<String, AnyObject>, error : String?) -> Void in
            if error != nil {
                print("\(error) : PostBoardVC")
            } else {
                if let stateT = data["state"] as? String,
                    let message = data["message"] as? String
                {
                    print("succece:))")
                    //                    self.state = stateT
                    //                    print(self.state)
//                    if self.state == "1" {
//                        //                        print("yet")
//                        //                        self.contentLikeNumTmp = self.contentLikeNumTmp + 1
//                        //                        print(self.contentLikeNumTmp)
//                        //                        self.contentLikeNum.text = "\(self.contentLikeNumTmp)" ////
//                        //
//                    }
                    
                } else {
                    //print("User객체 SimpleJsonParser인스턴스 failed")
                }
            }
        }
    }
    
    var pageInt = 1
    
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
    
    func plusInitGeneralBoard() {
        Alamofire
            .request(Router.GetList(type: "T01", page: "\(pageInt)", university: "가천대학교"))
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
            
            //let indexPath = generalListTableView.indexPathForItemAtPoint(point)
            DetailVC.contentT = generalBoards[indexPath!.row].contents
            DetailVC.keywords = generalBoards[indexPath!.row].keywords
            DetailVC.contentlikeNumT = String(generalBoards[indexPath!.row].numberOfLike)
            DetailVC.commentNumT = String(generalBoards[indexPath!.row].numberOfComment)
            DetailVC.code = generalBoards[indexPath!.row].code
            print(DetailVC.code)
        }
            
        else if segue.identifier == "keywordGeneralFirstSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[0]
        }
            
        else if segue.identifier == "keywordGeneralSecondSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[1]
        }
        else if segue.identifier == "keywordGeneralThirdSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:generalListTableView)
            let indexPath = generalListTableView.indexPathForRowAtPoint(point)
            
            KeywordVC.titleName = generalBoards[indexPath!.row].keywordArray[2]
        }
        else if segue.identifier == "generalPost" {
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
    
//    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
//        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
//            completion(data: data, response: response, error: error)
//            }.resume()
//    }
//    
//    func downloadImage(url: NSURL){
//        print("Download Started")
//        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
//        getDataFromUrl(url) { (data, response, error)  in
//            dispatch_async(dispatch_get_main_queue()) { () -> Void in
//                guard let data = data where error == nil else { return }
//                print(response?.suggestedFilename ?? "")
//                print("Download Finished")
//                //imageView.image = UIImage(data: data)
//            }
//        }
//    }

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
//                var imageView = UIImageView(frame: CGRectMake(10, 10, 375, 150))
//                imageView.image = image
//                self.image = imageView.image
                self.image = image
            }
        }).resume()
    }
}//
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
