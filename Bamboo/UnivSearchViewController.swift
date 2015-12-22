//
//  UnivSearchViewController.swift
//  Bamboo
//
//  Created by 박태현 on 2015. 12. 19..
//  Copyright © 2015년 ParkTaeHyun. All rights reserved.
//

import UIKit
import Alamofire

class UnivSearchViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    var isSearching = false
    var data = [String]()
    var filtered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
    }
    
    // MARK: - General custom Function
    func initSetting() {
        self.searchBar.delegate = self
        
        self.data = LibraryAPI().getNameFromUniversities()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectUniv" {
            let uuid = UIDevice.currentDevice().identifierForVendor?.UUIDString
            let cell = sender as! UITableViewCell
            let indexPath = self.searchTableView.indexPathForCell(cell)!
            
            User.sharedInstance().uuid = uuid!
            User.sharedInstance().point = "0"
            
            if isSearching == true {
                Alamofire
                    .request(.GET, "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Set_Default.php", parameters:["uuid" : uuid!, "university" : filtered[indexPath.row]])
                    .responseString{ response in
                        print(response.result.value)
                }
                User.sharedInstance().univ = filtered[indexPath.row]
            } else {
                Alamofire
                    .request(.GET, "http://ec2-52-68-50-114.ap-northeast-1.compute.amazonaws.com/bamboo/API/Bamboo_Set_Default.php", parameters:["uuid" : uuid!, "university" : data[indexPath.row]])
                    .responseString{response in
                        print(response.result.value)
                }
                User.sharedInstance().univ = data[indexPath.row]
            }
        }
    }
}

extension UnivSearchViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching == true {
            return filtered.count
        } else {
            return data.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCellWithIdentifier("UnivCell", forIndexPath: indexPath)
        if isSearching == true {
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
}

extension UnivSearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        isSearching = true
        return true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if (filtered.count == 0) {
            isSearching = false
        } else {
            isSearching = true
        }
        self.searchTableView.reloadData()
    }
}
