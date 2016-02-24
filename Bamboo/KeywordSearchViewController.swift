//
//  KeywordSearchViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2016. 1. 18..
//  Copyright © 2016년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class KeywordSearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate{
    
    var recentKeywordArray: Results<RecentKeyword>!
    var hotKeywordArray: [HotKeyword] = []
    var univKeywordArray: [UnivKeyword] = []
    var searchKeywordArray: [SearchKeyword] = []
    
    var searchController: UISearchController!
    var inputedKeyword = ""
    
    let recentKeyword = RecentKeyword()
    
    override func viewDidLoad() {
        recentKeywordCollectionView.dataSource = self
        hotKeywordCollectionView.dataSource = self
        univKeywordCollectionView.dataSource = self
        searchedKeywordTableView.dataSource = self
        
        searchedKeywordTableView.rowHeight = 68.0
        initSearchViewContollerInNav()
        
        setHotKeywordArray()
        setUnivKeywordArray()
    }
    
    override func viewWillAppear(animated: Bool) {
        readRecentKeywordListAndUpdateUI()
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
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
    }
    
    func setHotKeywordArray() {
        Alamofire
            .request(Router.GetHotKeyword())
            .responseCollection{ (response: Response<[HotKeyword], NSError>) in
                if response.result.isSuccess {
                    self.hotKeywordArray = (response.result.value)!
                }
                self.hotKeywordCollectionView.reloadData()
            }
    }
    
    func setUnivKeywordArray() {
        Alamofire
            .request(Router.GetUnivKeyword())
            .responseCollection{ (response: Response<[UnivKeyword], NSError>) in
                if response.result.isSuccess {
                    self.univKeywordArray = (response.result.value)!
                }
                self.univKeywordCollectionView.reloadData()
            }
    }
    
    func setSearchKeywordArray() {
        BBActivityIndicatorView.show("데이터를 검색중입니다.")
        Alamofire
            .request(Router.GetSearchKeyword(keyword: self.inputedKeyword))
            .responseCollection{ (response: Response<[SearchKeyword], NSError>) in
                if response.result.isSuccess {
                    self.searchKeywordArray = (response.result.value)!
                    if self.searchKeywordArray.isEmpty {
                        let descriptions = LibraryAPI.sharedInstance.isFailToSearch()
                        BBAlertView.alert(descriptions.title, message: descriptions.message)
                        self.searchedKeywordTableView.hidden = true
                    }
                    BBActivityIndicatorView.hide()
                }
                self.searchedKeywordTableView.reloadData()
            }
    }
    
    func readRecentKeywordListAndUpdateUI(){
        let uiRealm = try! Realm()
        recentKeywordArray = uiRealm.objects(RecentKeyword).sorted("searchedDate", ascending: false)
        self.recentKeywordCollectionView.reloadData()
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
        self.inputedKeyword = searchBar.text!
        
        setSearchKeywordArray()
        
        writeRealm()
        self.recentKeywordCollectionView.reloadData()
    }
    
    func writeRealm() {
        let uiRealm = try! Realm()

        try! uiRealm.write {
            self.recentKeyword.keywordName = inputedKeyword
            self.recentKeyword.searchedDate = NSDate()
            uiRealm.add(recentKeyword)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchedKeywordTableView.hidden = true
    }
}

extension KeywordSearchViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentKeywordCollectionView {
            return recentKeywordArray.count
        } else if collectionView == hotKeywordCollectionView {
            return hotKeywordArray.count
        } else {
            return univKeywordArray.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == recentKeywordCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("recentKeywordCell", forIndexPath: indexPath) as! RecentKeywordCollectionViewCell
            cell.content.text = recentKeywordArray[indexPath.row].keywordName
            
            return cell
        } else if collectionView == hotKeywordCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hotKeywordCell", forIndexPath: indexPath) as! HotKeywordCollectionViewCell
            cell.content.text = hotKeywordArray[indexPath.row].keyword
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("univKeywordCell", forIndexPath: indexPath) as! UnivKeywordCollectionViewCell
            cell.content.text = univKeywordArray[indexPath.row].keyword
            
            return cell
        }
    }
}

extension KeywordSearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchKeywordArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchedKeywordTableView.dequeueReusableCellWithIdentifier("searchedDataCell", forIndexPath: indexPath) as! SearchedDataTableViewCell
        
        cell.keywordNameLabel.text = self.searchKeywordArray[indexPath.row].keyword
        cell.countLabel.text = self.searchKeywordArray[indexPath.row].count + "개"
        
        return cell
    }
}
