//
//  KeywordSearchViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 1. 18..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class KeywordSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var recentKeywordArr = ["#금요일","#비오는날","#축축함"]
    var hotKeywordArr = ["#아", "#이", "#폰"]
    var univKeywordArr = ["#수강신청","#개강","#학교다니기싫다"]
    
    override func viewDidLoad() {
        recentKeyword.delegate = self
        recentKeyword.dataSource = self
        hotKeyword.delegate = self
        hotKeyword.dataSource = self
        univKeyword.delegate = self
        univKeyword.dataSource = self
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    @IBOutlet weak var recentKeyword: UICollectionView!
    
    @IBOutlet weak var hotKeyword: UICollectionView!
    
    @IBOutlet weak var univKeyword: UICollectionView!
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentKeyword {
            return recentKeywordArr.count
        } else if collectionView == hotKeyword {
            return hotKeywordArr.count
        } else {
            return univKeywordArr.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == recentKeyword {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("recentKeywordCell", forIndexPath: indexPath) as! RecentKeywordCollectionViewCell
            cell.content.text = recentKeywordArr[indexPath.row]
            
            return cell
            
        }
        else if collectionView == hotKeyword {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hotKeywordCell", forIndexPath: indexPath) as! HotKeywordCollectionViewCell
            cell.content.text = hotKeywordArr[indexPath.row]
            
            return cell
            
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("univKeywordCell", forIndexPath: indexPath) as! UnivKeywordCollectionViewCell
            cell.content.text = univKeywordArr[indexPath.row]
            
            return cell
            
        }
    }
    
}
