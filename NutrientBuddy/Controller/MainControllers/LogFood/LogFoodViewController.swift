//
//  logFoodViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 24/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class LogFoodViewController: UIViewController {
    //MARK: loading database
    var database: [FoodInfo] = []
    var dictViewCont: [String:[String]] = [:]
    var categoryViewCont: [String] = []
    //var allWords: [String] = []
    var codeDict: [String: [Int]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        database = foodData().loadFoodDatabase()!
        dictViewCont = foodData().categorizeItems()
        categoryViewCont = foodData().categorizeItems().keys.sorted(by: <)
        //allWords = BagOfWord().loadAllWords()
        codeDict = BagOfWord().loadDictionary()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: pass to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // SearchViewControlller
        if segue.identifier == "loadSearchPage" {
            let searchViewController: SearchViewController = segue.destination as! SearchViewController
            searchViewController.codeDict = codeDict
            searchViewController.database = database
            //pass for catogory view controller
            searchViewController.catDict = dictViewCont
            searchViewController.catCategories = categoryViewCont
        }
    }
}

