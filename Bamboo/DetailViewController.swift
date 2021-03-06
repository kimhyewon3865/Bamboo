//
//  DetailViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 27..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func backBtnClicked(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    var contentT = ""
    var keywords = ""
    var contentlikeNumT = ""
    var commentNumT = ""
    var code : String = ""
    var keywordArray: [String] = []
    var commentContent = ""
    var contentCommentNumTmp = 0
    var contentLikeNumTmp = 0
    var state = ""
    var timeSpace = ""
    var dateFormatter = NSDateFormatter()
    var imageT = ""
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var contentLike: UIButton!
    
    @IBOutlet weak var contentLikeNum: UILabel!
    
    @IBOutlet weak var commentNum: UILabel!
    
    @IBOutlet weak var keyword1: UIButton!
    @IBOutlet weak var keyword2: UIButton!
    @IBOutlet weak var keyword3: UIButton!
    @IBOutlet weak var keyword4: UIButton!
    
    @IBOutlet weak var keyword5: UIButton!
    @IBOutlet weak var keyword6: UIButton!
    
    @IBOutlet weak var commentTF: UITextField!
    
    @IBAction func sendButton(sender: AnyObject) {
        commentContent = commentTF.text!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let str = dateFormatter.stringFromDate(NSDate())
        if commentContent != "" {
        let commentTmp = Comment(commentP: commentContent, regdtP: str)
        //= Comment(commentP: commentContent, regdtP: dateFormatter.stringFromDate(NSDate())
        commentsArr.insert(commentTmp, atIndex: 0)
        //commentsArr.append(commentTmp)
        commentTableView.reloadData()
        commentTF.text = ""
        contentCommentNumTmp = contentCommentNumTmp + 1
        commentNum.text = String(contentCommentNumTmp)
        setComment()
        }
        else {
            let descriptions = LibraryAPI.sharedInstance.isNoContent()
            BBAlertView.alert(descriptions.title, message: descriptions.message)

        }
        
    }
    var commentsArr : [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(code)
        initDetailView()
        initSetting()
        
        contentCommentNumTmp = Int(commentNumT)!
        contentLikeNumTmp = Int(contentlikeNumT)!
        contentLike.addTarget(self, action: #selector(DetailViewController.contentLikeFunc), forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        initDetailView()
        initSetting()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.catchIt(_:)), name: "myNotif", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func contentLikeFunc() {
        setLike()
        let image = UIImage(named: "like")
        let image2 = UIImage(named: "unlike")!
        
        if contentLike.imageView?.image == image2 {
            contentLike.setImage(image, forState: .Normal)
            var tmp = Int(contentLikeNum.text!)
            tmp = tmp! + 1
            contentLikeNum.text = "\(tmp!)"
        } else {
            contentLike.setImage(image2, forState: .Normal)
            var tmp = Int(contentLikeNum.text!)
            tmp = tmp! - 1
            contentLikeNum.text = "\(tmp!)"

        }
        
        //contentLike.setImage(image, forState: .Normal)
        //contentLikeNum.text = String(contentLikeNumTmp)
    }
    
    func initDetailView() {
        Alamofire
            .request(Router.GetComment(uuid: User.sharedInstance().uuid, bCode: code))
            .responseCollection { (response: Response<[Comment], NSError>) in
                if response.result.isSuccess {
                    self.commentsArr = response.result.value!
                }
                
                self.commentTableView.reloadData()
        }
    }
    
    func setComment() {
        Alamofire
            .request(Router.SetComment(uuid: User.sharedInstance().uuid, bCode: code, comment: commentContent))
            
            .responseString { response in
                print(response)
                if response.result.isSuccess {
                }
                
                self.commentTableView.reloadData()
                
        }
    }
    
    func setLike() {
        let jsonParser = SimpleJsonParser()
        jsonParser.HTTPGetJson("http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Set_Like.php?b_code=\(code)&uuid=\(User.sharedInstance().uuid)") {
            (data : Dictionary<String, AnyObject>, error : String?) -> Void in
            if error != nil {
                print("\(error) : PostBoardVC")
            } else {
                if let stateT = data["state"] as? String,
                    let _ = data["message"] as? String
                {
                    print("succece:)")
                    self.state = stateT
                    print(self.state)
//                    if self.state == "1" {
//                        print("yet")
//                        self.contentLikeNumTmp = self.contentLikeNumTmp + 1
//                        print(self.contentLikeNumTmp)
//                        self.contentLikeNum.text = "\(self.contentLikeNumTmp)" ////
//                        
//                    }
                    
                } else {
                    //print("User객체 SimpleJsonParser인스턴스 failed")
                }
            }
        }
    }
    
    func initSetting() {
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.content.text = contentT
        self.contentLikeNum.text = contentlikeNumT
        self.commentNum.text = commentNumT
        
        if self.keywords != "" {
            let tmpKeywordArray = keywords.characters.split{$0 == ","}.map(String.init)
            keywordArray = tmpKeywordArray
        }
        
        if imageT != "" {
            backgroundImage.alpha = 0.5
            backgroundImage.downloadedFrom(link: imageT, contentMode: .ScaleToFill)
        }
        if(keywordArray.count == 0){
            keyword1.hidden = true
            keyword2.hidden = true
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        } else if(keywordArray.count == 1){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.hidden = true
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        } else if(keywordArray.count == 2){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        } else if(keywordArray.count == 3){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        } else if(keywordArray.count == 4){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.setTitle("#" + keywordArray[3], forState: .Normal)
            keyword5.hidden = true
            keyword6.hidden = true
        } else if(keywordArray.count == 5){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.setTitle("#" + keywordArray[3], forState: .Normal)
            keyword5.setTitle("#" + keywordArray[4], forState: .Normal)
            keyword6.hidden = true
        } else if(keywordArray.count == 6){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.setTitle("#" + keywordArray[3], forState: .Normal)
            keyword5.setTitle("#" + keywordArray[4], forState: .Normal)
            keyword6.setTitle("#" + keywordArray[5], forState: .Normal)
        }
        
        if state == "1" {
            let image = UIImage(named: "like")
            contentLike.setImage(image, forState: .Normal)
        } else {
            let image = UIImage(named: "unlike")!
            contentLike.setImage(image, forState: .Normal)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !commentsArr.isEmpty {
            return commentsArr.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCell
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        if !commentsArr.isEmpty {
            let olderDate = dateFormatter.dateFromString(commentsArr[indexPath.row].regdt)
            //print(commentsArr[indexPath.row].comment)
            //print(LibraryAPI.sharedInstance.compareDate(olderDate!))
            //cell.time.text = CountTimeManager.compareDate(olderDate!)
            cell.time.text = LibraryAPI.sharedInstance.compareDate(olderDate!)
            cell.commentContent.text = commentsArr[indexPath.row].comment
            cell.commnetLikeNum.text = commentsArr[indexPath.row].numberOfLike
 
            if commentsArr[indexPath.row].isLike == "1" {
                let image = UIImage(named: "like")
                cell.likeBtn.setImage(image, forState: .Normal)
            } else {
                let image = UIImage(named: "unlike")
                cell.likeBtn.setImage(image, forState: .Normal)

            }
        }
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(DetailViewController.commentLikeFunc(_:)), forControlEvents: .TouchUpInside)

        return cell
    }
    
    func commentLikeFunc(sender: UIButton) {
        let index = sender.tag
        let idx = commentsArr[index].idx
        Alamofire
            .request(Router.SetCommentLike(uuid: User.sharedInstance().uuid, idx: "\(idx)"))
            
            .responseString { response in
                print(response)
                if response.result.isSuccess {
                }
        
                //self.commentTableView.reloadData()
                
        }

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "keywordDetailFirstSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            
            KeywordVC.titleName = keywordArray[0]
        } else if segue.identifier == "keywordDetailSecondSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            
            KeywordVC.titleName = keywordArray[1]
            
        } else if segue.identifier == "keywordDetailThirdSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            
            KeywordVC.titleName = keywordArray[2]
            
        } else if segue.identifier == "keywordDetailFourthSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            
            KeywordVC.titleName = keywordArray[3]
            
        } else if segue.identifier == "keywordDetailFifthSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            
            KeywordVC.titleName = keywordArray[4]
            
        } else if segue.identifier == "keywordDetailSixthSegue" {
            let KeywordVC = segue.destinationViewController as! KeywordViewController
            
            KeywordVC.titleName = keywordArray[5]
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}




