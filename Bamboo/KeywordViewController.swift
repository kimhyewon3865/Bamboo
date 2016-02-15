//
//  KeywordViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 27..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class KeywordViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var keywordView: UICollectionView!
    
    var titleName = ""
    var detailOrMega = 1
    var keywords : [UnivBoard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.keywordView.delegate = self
        self.keywordView.dataSource = self
        self.btnBest.hidden = true
        self.btnNew.hidden = true
        btnBest.addTarget(self, action: "btnBestFunc", forControlEvents: .TouchUpInside)
        btnNew.addTarget(self, action: "btnNewFunc", forControlEvents: .TouchUpInside)
btnWrite.addTarget(self, action: "btnWriteFunc", forControlEvents: .TouchUpInside)
        initUnivBoard()
        
        // Do any additional setup after loading the view.
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
        cell.backgroundImage.downloadedFrom(link: keywords[indexPath.row].imgURL, contentMode: .ScaleAspectFit)

        if(keywords[indexPath.row].keywordArray.count == 0){
            cell.keywordFirst.hidden = true
            cell.keywordSecond.hidden = true
            cell.keywordThird.hidden = true
        }
        else if(keywords[indexPath.row].keywordArray.count == 1){
            cell.keywordFirst.hidden = false
            cell.keywordFirst.setTitle("#"+self.keywords[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.hidden = true
            cell.keywordThird.hidden = true
            //                cell.keywordSecond.setTitle("", forState: .Normal)
            //                cell.keywordThird.setTitle("", forState: .Normal)
        }
        else if(keywords[indexPath.row].keywordArray.count == 2){
            cell.keywordFirst.hidden = false
            cell.keywordSecond.hidden = false
            cell.keywordFirst.setTitle("#"+self.keywords[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.setTitle("#"+self.keywords[indexPath.row].keywordArray[1], forState: .Normal)
            cell.keywordThird.hidden = true
        }
        else {
            cell.keywordFirst.hidden = false
            cell.keywordSecond.hidden = false
            cell.keywordThird.hidden = false
            cell.keywordFirst.setTitle("#"+self.keywords[indexPath.row].keywordArray[0], forState: .Normal)
            cell.keywordSecond.setTitle("#"+self.keywords[indexPath.row].keywordArray[1], forState: .Normal)
            cell.keywordThird.setTitle("#"+self.keywords[indexPath.row].keywordArray[2], forState: .Normal)
        }

//        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, heights[indexPath.row])
        
        return cell
    }
    
    func initUnivBoard() {
        if detailOrMega == 2 {
            BBActivityIndicatorView.show("로딩중입니다><")
            Alamofire
                .request(Router.GetList(type: "T05", page: "1", university: User.sharedInstance().univ, uuid: User.sharedInstance().uuid))
                
                .responseCollection { (response: Response<[UnivBoard], NSError>) in
                    if response.result.isSuccess {
                        BBActivityIndicatorView.hide()
                        self.keywords = response.result.value!
                        print(response)
                        print(response.result.value)
                        //                    if self.keywords.isEmpty {
                        //                        self.hiddenView.hidden = false
                        //                        self.univListTableView.hidden = true
                        //                    }
                        //                    else {
                        //                        self.hiddenView.hidden = true
                        //                        self.univListTableView.hidden = false
                        //                    }
                        
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
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
