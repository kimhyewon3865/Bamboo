//
//  DetailViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 27..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    var univBoards : [UnivBoard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDetailView()
        
//        self.content.text = contentTxt
//        self.contentLikeNum.text = contentLiketNumTxt
//        self.commentNum.text = commentNumTxt
        
        // Do any additional setup after loading the view.
        if !univBoards.isEmpty {
        self.content.text = self.univBoards[0].contents
        }
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
    
    var code : String = ""
    //var contentTxt : String

//    var contentLiketNumTxt : String = ""
//    var commentNumTxt : String = ""
    //keyword 변수
    
    
    
    func initDetailView() {
        Alamofire
            .request(Router.GetDetail(bCode: code))
        //print(code)
            .responseCollection { (response: Response<[UnivBoard], NSError>) in
                if response.result.isSuccess {
                    self.univBoards = response.result.value!
                    print(response.result)
                    print(response.result.value)
                }
                if self.univBoards.isEmpty {
                    print(1)
                    //self.content.text = self.univBoards[0].contents
                }
                self.view.reloadInputViews()
                //self.univListTableView.reloadData()
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