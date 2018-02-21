//
//  CategoryViewController.swift
//  DemoSearch
//
//  Created by Gemma Jing on 21/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: get database and filtered data
    var database: [FoodInfo] = []
    var dict:[String:[String]] = [:]
    var categories: [String] = []
    var filteredData: [String] = []
    var isSearching: Bool = false
    
    //MARK: search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = categories.filter({(text) -> Bool in
            let temp: NSString = text as NSString
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if searchText == "" {
            filteredData = categories
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: load table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        
        if isSearching {
            let item = filteredData[indexPath.row].split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
            cell?.textLabel?.text = String(item[0])
        } else {
            let item = categories[indexPath.row].split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
            cell?.textLabel?.text = String(item[0])
        }
        
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    //MARK: pass to the next view -> CatagoryDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategoryDetails" {
            var selectedRowIndex = self.tableView.indexPathForSelectedRow
            let categoryDetailsViewController: CategoryDetailsViewController = segue.destination as! CategoryDetailsViewController

            var item: String = ""
            if isSearching{
               item  = filteredData[(selectedRowIndex?.row)!]
                //let st = database!.filter{$0.Food_Name == item}
                
            } else {
               item = categories[(selectedRowIndex?.row)!]
            }
            
            guard let categoryDetials = dict[item]
                else{
                    print("GJ: something wrong with category string array")
                    return
                }
            categoryDetailsViewController.foodItems = categoryDetials
            categoryDetailsViewController.database = database
        }
    }
    
}
