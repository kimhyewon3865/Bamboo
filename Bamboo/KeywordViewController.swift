//
//  KeywordViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2015. 12. 27..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class KeywordViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var keywordView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keywordView.delegate = self
        self.keywordView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = keywordView.dequeueReusableCellWithReuseIdentifier("keywordCell", forIndexPath: indexPath) as! KeywordCollectionViewCell
        
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
