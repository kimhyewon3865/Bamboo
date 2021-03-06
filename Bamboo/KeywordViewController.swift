//
//  KeywordViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 27..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class KeywordViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var keywordView: UICollectionView!
    
    var titleName = ""
    var detailOrMega = 1
    var keywords : [GeneralBoard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        
        btnBest.addTarget(self, action: #selector(KeywordViewController.btnBestFunc), forControlEvents: .TouchUpInside)
        btnNew.addTarget(self, action: #selector(KeywordViewController.btnNewFunc), forControlEvents: .TouchUpInside)
        btnWrite.addTarget(self, action: #selector(KeywordViewController.btnWriteFunc), forControlEvents: .TouchUpInside)
        initUnivBoard()
        if detailOrMega == 1 {
            navigationItem.title = "#" + titleName
        } else {
            navigationItem.title = titleName
        }
        
        self.keywordView.delegate = self
        self.keywordView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UIViewController.catchIt(_:)), name: "myNotif", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return keywords.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("keywordCell", forIndexPath: indexPath) as! KeywordCollectionViewCell
        
        cell.content.setTitle(keywords[indexPath.row].contents, forState: .Normal)
        if keywords[indexPath.row].islike == "0" {
            let image: UIImage = UIImage(named: "unlike")!
            cell.likeImage.setImage(image, forState: UIControlState.Normal)
        } else {
            let image: UIImage = UIImage(named: "like")!
            cell.likeImage.setImage(image, forState: UIControlState.Normal)
        }
        
        cell.likeNum.text = String(keywords[indexPath.row].numberOfLike)
        cell.commentNum.text = String(keywords[indexPath.row].numberOfComment)
        
        if keywords[indexPath.row].imgURL != "" {
            cell.backgroundImage.alpha = 0.4
            cell.backgroundImage.downloadedFrom(link: keywords[indexPath.row].imgURL, contentMode: .ScaleToFill)
        }
        
        if(keywords[indexPath.row].keywordArray.count == 0){
            cell.keywordFirst.hidden = true
            cell.keywordSecond.hidden = true
            cell.keywordThird.hidden = true
        } else if(keywords[indexPath.row].keywordArray.count == 1){
            cell.keywordFirst.hidden = false
            cell.keywordFirst.setTitle("#"+self.keywords[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.hidden = true
            cell.keywordThird.hidden = true
        } else if(keywords[indexPath.row].keywordArray.count == 2){
            cell.keywordFirst.hidden = false
            cell.keywordSecond.hidden = false
            cell.keywordFirst.setTitle("#"+self.keywords[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.setTitle("#"+self.keywords[indexPath.row].keywordArray[1], forState: .Normal)
            cell.keywordThird.hidden = true
        } else {
            cell.keywordFirst.hidden = false
            cell.keywordSecond.hidden = false
            cell.keywordThird.hidden = false
            cell.keywordFirst.setTitle("#"+self.keywords[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.setTitle("#"+self.keywords[indexPath.row].keywordArray[1], forState: .Normal)
            cell.keywordThird.setTitle("#"+self.keywords[indexPath.row].keywordArray[2], forState: .Normal)
        }
        
        cell.keywordFirst.addTarget(self, action: #selector(KeywordViewController.keywordClicked(_:)), forControlEvents: .TouchUpInside)
        cell.keywordSecond.addTarget(self, action: #selector(KeywordViewController.keywordClicked(_:)), forControlEvents: .TouchUpInside)
        cell.keywordThird.addTarget(self, action: #selector(KeywordViewController.keywordClicked(_:)), forControlEvents: .TouchUpInside)
        cell.likeImage.tag = indexPath.row
        cell.likeImage.addTarget(self, action: #selector(KeywordViewController.setLike(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func setLike(sender: AnyObject) {
        let code = keywords[sender.tag].code
        Alamofire.request(Router.SetLike(uuid: User.sharedInstance().uuid, bCode: code))

//        let jsonParser = SimpleJsonParser()
//        jsonParser.HTTPGetJson("http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Set_Like.php?b_code=\(code)&uuid=\(User.sharedInstance().uuid)") {
//            (data : Dictionary<String, AnyObject>, error : String?) -> Void in
//            if error != nil {
//                print("\(error) : PostBoardVC")
//            } else {
//                if let _ = data["state"] as? String,
//                    let _ = data["message"] as? String
//                {
//                    print("succece:))")
//                    //                    self.state = stateT
//                    //                    print(self.state)
//                    //                    if self.state == "1" {
//                    //                        //                        print("yet")
//                    //                        //                        self.contentLikeNumTmp = self.contentLikeNumTmp + 1
//                    //                        //                        print(self.contentLikeNumTmp)
//                    //                        //                        self.contentLikeNum.text = "\(self.contentLikeNumTmp)" ////
//                    //                        //
//                    //                    }
//                    
//                } else {
//                    //print("User객체 SimpleJsonParser인스턴스 failed")
//                }
//            }
//        }
    }
    
    func keywordClicked(sender :UIButton) {
        let astring = sender.titleLabel?.text
        titleName = astring!.stringByReplacingOccurrencesOfString("#", withString: "")
        navigationItem.title = "#" + titleName
        detailOrMega = 1
        initUnivBoard()
    }
    
    func initUnivBoard() {
        BBActivityIndicatorView.show("로딩중입니다><")
        
        if detailOrMega == 1 {
            Alamofire
                .request(Router.GetKeywordList(uuid: User.sharedInstance().uuid, keyword: titleName))
                .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                    if response.result.isSuccess {
                        BBActivityIndicatorView.hide()
                        self.keywords = response.result.value!
                        print(response)
                        print(response.result.value)
                    }
                    self.keywordView.reloadData()
            }
        } else if detailOrMega == 2 {
            Alamofire
                .request(Router.GetList(type: "T05", page: "1", university: User.sharedInstance().univ, uuid: User.sharedInstance().uuid))
                .responseCollection { (response: Response<[GeneralBoard], NSError>) in
                    if response.result.isSuccess {
                        BBActivityIndicatorView.hide()
                        self.keywords = response.result.value!
                        print(response)
                        print(response.result.value)
                    }
                    self.keywordView.reloadData()
            }
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
    @IBAction func backBtnClicked(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let DetailVC = segue.destinationViewController as! DetailViewController
            let point : CGPoint = sender!.convertPoint(CGPointZero, toView:keywordView)
            let indexPath = keywordView.indexPathForItemAtPoint(point)
            print(keywords[indexPath!.row].contents)
            DetailVC.contentT = keywords[indexPath!.row].contents
            DetailVC.keywords = keywords[indexPath!.row].keywords
            DetailVC.contentlikeNumT = String(keywords[indexPath!.row].numberOfLike)
            DetailVC.commentNumT = String(keywords[indexPath!.row].numberOfComment)
            DetailVC.code = keywords[indexPath!.row].code
            DetailVC.imageT = keywords[indexPath!.row].imgURL
            print(DetailVC.code)
        }
    }
}