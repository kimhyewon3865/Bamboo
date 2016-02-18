//
//  KeywordSearchViewController.swift
//  Bamboo
//
//  Created by 김혜원 on 2016. 1. 18..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit

class KeywordSearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate{
    
    let recentKeywordArr = ["#금요일","#비오는날","#축축함","#축축함","#축축함","#축축함","#축축함"]
    let hotKeywordArr = ["#아", "#이", "#폰","#축축함","#축축함","#축축함","#축축함","#축축함"]
    let univKeywordArr = ["#수강신청","#개강","#학교다니기싫다","#축축함","#축축함","#축축함","#축축함"]
    
    let searchedKeywordArr: [(String, Int)] = [("aaa",3)]
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        recentKeywordCollectionView.dataSource = self
        hotKeywordCollectionView.dataSource = self
        univKeywordCollectionView.dataSource = self
        searchedKeywordTableView.dataSource = self
        
        searchedKeywordTableView.rowHeight = 68.0
        initSearchViewContollerInNav()
    }
    
    @IBOutlet weak var recentKeywordCollectionView: UICollectionView!
    @IBOutlet weak var hotKeywordCollectionView: UICollectionView!
    @IBOutlet weak var univKeywordCollectionView: UICollectionView!
    @IBOutlet weak var searchedKeywordTableView: UITableView!
    
    @IBAction func backButtonClicked(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    func initSearchViewContollerInNav() {
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let keywordVC = segue.destinationViewController as! KeywordViewController
        
        if segue.identifier == "SelectKeyword1" {
            let cell = sender! as! RecentKeywordCollectionViewCell
            keywordVC.titleName = cell.content.text!
        } else if segue.identifier == "SelectKeyword2" {
            let cell = sender! as! HotKeywordCollectionViewCell
            keywordVC.titleName = cell.content.text!
        } else if segue.identifier == "SelectKeyword3" {
            let cell = sender! as! UnivKeywordCollectionViewCell
            keywordVC.titleName = cell.content.text!
        } else {
            let cell = sender! as! SearchedDataTableViewCell
            keywordVC.titleName = cell.keywordNameLabel.text!
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchedKeywordTableView.hidden = false
    }
}

extension KeywordSearchViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentKeywordCollectionView {
            return recentKeywordArr.count
        } else if collectionView == hotKeywordCollectionView {
            return hotKeywordArr.count
        } else {
            return univKeywordArr.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == recentKeywordCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("recentKeywordCell", forIndexPath: indexPath) as! RecentKeywordCollectionViewCell
            cell.content.text = recentKeywordArr[indexPath.row]
            
            return cell
        } else if collectionView == hotKeywordCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hotKeywordCell", forIndexPath: indexPath) as! HotKeywordCollectionViewCell
            cell.content.text = hotKeywordArr[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("univKeywordCell", forIndexPath: indexPath) as! UnivKeywordCollectionViewCell
            cell.content.text = univKeywordArr[indexPath.row]
            
            return cell
        }
    }
}

extension KeywordSearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedKeywordArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchedKeywordTableView.dequeueReusableCellWithIdentifier("searchedDataCell", forIndexPath: indexPath) as! SearchedDataTableViewCell
        
        cell.keywordNameLabel.text = self.searchedKeywordArr[indexPath.row].0
        cell.countLabel.text = "\(self.searchedKeywordArr[indexPath.row].1)회"
        
        return cell
    }
}
