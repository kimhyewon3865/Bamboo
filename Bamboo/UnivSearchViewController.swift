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
    var isSearching = false         //검색중인지 여부
    var data = [String]()           //필터 안된 초기 데이터
    var filtered: [String] = []     //검색으로 필터된 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = LibraryAPI().getNameFromUniversities()
    }
    
    func alertSuccessMessage(univName: String) {
        let descriptions = LibraryAPI.sharedInstance.clickCellFromUnivSearchVC(univName)
        BBAlertView.alert(descriptions.title, message: descriptions.message)
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
                var university = ""
                if searchBar.text == "" {
                    university = data[indexPath.row]
                } else {
                    university = filtered[indexPath.row]
                }
                Alamofire
                    .request(Router.SetDefault(uuid: uuid!, university: university))
                    .responseString{ response in
                        if response.result.isSuccess {
                            print("SetDefault Success")
                            print((response.result.value)!)
                        } else {
                            print("SetDefault Falied")
                        }
                }
                User.sharedInstance().univ = university
            } else {
                Alamofire
                    .request(Router.SetDefault(uuid: uuid!, university: data[indexPath.row]))
                    .responseString{response in
                        if response.result.isSuccess {
                            print("SetDefault Success")
                            print((response.result.value)!)
                        } else {
                            print("SetDefault Falied")
                        }
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
        cell.textLabel?.textColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1)
        cell.textLabel?.font = UIFont(name: "AppleGothic", size: 17.0)
        
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
