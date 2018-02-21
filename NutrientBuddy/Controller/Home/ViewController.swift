//
//  ViewController.swift
//  DemoSearch
//
//  Created by Gemma Jing on 05/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: loading database
    var database: [FoodInfo] = []
    var dictViewCont: [String:[String]] = [:]
    var categoryViewCont: [String] = []
    //var allWords: [String] = []
    var codeDict: [String: [Int]] = [:]
    
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
    }

    @IBAction func testingTapped(_ sender: UIButton) {
        let diary = NutrientDiaryCoreDataHandler.fetchObject()!
        if diary.count != 0 {
            for eachItem in diary{
                print("GJ: date: \(String(describing: eachItem.date)), food (\(String(describing: eachItem.foodname)), amount: \(eachItem.amount)")
            }
        }
        let nutrientSelectionViewController = storyboard?.instantiateViewController(withIdentifier: "nutrientSelection") as! NutrientTypeSelectionViewController
        present(nutrientSelectionViewController, animated: true, completion: nil)
        
        
    }

    
}

