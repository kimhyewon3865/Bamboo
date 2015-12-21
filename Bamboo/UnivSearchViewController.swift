//
//  UnivSearchViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 19..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit

class UnivSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    var isSearching = false
    let data = ["aaa","baa","caa","cwa","aqweaa","faa","powaa","eraa","laa","qweqwrdaa"]
    var filteredData = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
    }
    
    // MARK: - UITableView DataSource Function
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return filteredData.count
        } else {
            return data.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCellWithIdentifier("UnivCell", forIndexPath: indexPath)
        print(isSearching)
        if isSearching == true {
            let filteredDataArray = Array(filteredData)
            cell.textLabel?.text = filteredDataArray[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    // MARK: - UITableView Delegate Function
    
    // MARK: - UISearchController Delegate Function
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        isSearching = true;
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isSearching = false
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = self.searchController.searchBar.text
        
        if searchString == "" {
            filteredData.removeAll(keepCapacity: true)
        } else {
            for eachWords in data {
                if eachWords.hasPrefix(searchString!) {
                    filteredData.insert(eachWords)
                } else {
                    filteredData.remove(eachWords)
                }
            }
        }
        self.searchTableView.reloadData()
    }
    
    // MARK: - General custom Function
    func initSetting() {
        //self.topView.backgroundColor = nil
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        self.topView.addSubview(self.searchController.searchBar)
        
        self.definesPresentationContext = true
        self.searchController.searchBar.sizeToFit()
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
