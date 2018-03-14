//
//  CatagoryDetailsViewController.swift
//  DemoSearch
//
//  Created by Gemma Jing on 22/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {
    
    var typeOfMeal: String = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: get database and filtered data
    var database: [FoodInfo] = []
    var foodItems: [String] = [] // get from previous segue
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
        filteredData = foodItems.filter({(text) -> Bool in
            let temp: NSString = text as NSString
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if searchText == "" {
            filteredData = foodItems
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
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell")
        
        if isSearching {
            let item = filteredData[indexPath.row]
            cell?.textLabel?.text = String(item)
        } else {
            let item = foodItems[indexPath.row]
            cell?.textLabel?.text = String(item)
        }
        
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    //MARK: pass to the next segue -> food information view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoodInfo" {
            var selectedRowIndex = self.tableView.indexPathForSelectedRow
            let foodInfoTableViewController: FoodInformationTableViewController = segue.destination as! FoodInformationTableViewController
            var item: String = ""
            
            if isSearching{
                item = filteredData[(selectedRowIndex?.row)!]
                
            } else {
                item = foodItems[(selectedRowIndex?.row)!]
            }
            
            let strutArray = database.filter{$0.Food_Name == item.replacingOccurrences(of: " ", with: "_")}
            foodInfoTableViewController.selectedFoodInfo = strutArray[0]
            foodInfoTableViewController.typeOfMeal = self.typeOfMeal
        }
    }

}
