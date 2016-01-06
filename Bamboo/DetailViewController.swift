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
    var details : Detail?
    
    //var details : [Detail] = []
    var contentT = ""
    var keywords = ""
    var contentlikeNumT = ""
    var commentNumT = ""
    var code : String = ""
    var keywordArray: [String] = []

    @IBOutlet weak var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(code)
        initDetailView()
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.content.text = contentT
        self.contentLikeNum.text = contentlikeNumT
        self.commentNum.text = commentNumT
        if self.keywords != "" {
            let tmpKeywordArray = keywords.characters.split{$0 == ","}.map(String.init)
            keywordArray = tmpKeywordArray
        }
        
        if(keywordArray.count == 0){
            keyword1.hidden = true
            keyword2.hidden = true
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        }
        else if(keywordArray.count == 1){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        }
        else if(keywordArray.count == 2){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        }

        else if(keywordArray.count == 3){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword3.hidden = true
            keyword4.hidden = true
            keyword5.hidden = true
            keyword6.hidden = true
        }

        else if(keywordArray.count == 4){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.setTitle("#" + keywordArray[3], forState: .Normal)
            keyword5.hidden = true
            keyword6.hidden = true
        }

        else if(keywordArray.count == 5){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.setTitle("#" + keywordArray[3], forState: .Normal)
            keyword5.setTitle("#" + keywordArray[4], forState: .Normal)
            keyword6.hidden = true
        }

        else if(keywordArray.count == 6){
            keyword1.setTitle("#" + keywordArray[0], forState: .Normal)
            keyword2.setTitle("#" + keywordArray[1], forState: .Normal)
            keyword3.setTitle("#" + keywordArray[2], forState: .Normal)
            keyword4.setTitle("#" + keywordArray[3], forState: .Normal)
            keyword5.setTitle("#" + keywordArray[4], forState: .Normal)
            keyword6.setTitle("#" + keywordArray[5], forState: .Normal)
        }

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
        //        self.content.text = contentTxt
//        self.contentLikeNum.text = contentLiketNumTxt
//        self.commentNum.text = commentNumTxt
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var content: UILabel!

    @IBAction func contentLike(sender: AnyObject) {
    }
    @IBOutlet weak var contentLikeNum: UILabel!

    @IBOutlet weak var commentNum: UILabel!
    
    @IBAction func sendBtn(sender: AnyObject) {
    }
    @IBOutlet weak var keyword1: UIButton!
    @IBOutlet weak var keyword2: UIButton!
    @IBOutlet weak var keyword3: UIButton!
    @IBOutlet weak var keyword4: UIButton!
    
    @IBOutlet weak var keyword5: UIButton!
    @IBOutlet weak var keyword6: UIButton!

    
    //var contentTxt : String

//    var contentLiketNumTxt : String = ""
//    var commentNumTxt : String = ""
    //keyword 변수
    
    
    
    func initDetailView() {
        Alamofire
            .request(Router.GetDetail(bCode: code))
            .responseJSON { response in
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        //print(code)
        
//            .responseCollection { (response: Response<[Detail], NSError>) in
//                if response.result.isSuccess {
//                    self.details = response.result.value!
//                    print(response)
//                    print(response.result.value)
//                }
//                if self.details.isEmpty {
//                    print(1)
//                    //self.content.text = self.univBoards[0].contents
//                }
//                self.view.reloadInputViews()
//                //self.univListTableView.reloadData()
//        }
        
//            .responseObject { (response: Response<Detail, NSError>) in
//                //debugPrint(response)
//        }

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        //return (details?.comment.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCell
        cell.time.text = details?.comment[indexPath.row].regdt
        cell.commentContent.text = details?.comment[indexPath.row].comment
        cell.commnetLikeNum.text = String(details?.comment[indexPath.row].numberOfLike)
        
        
        
        return cell
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
