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
    var allWords: [String] = []
    var codeDict: [String: [Int]] = [:]
    
    //MARK: pass to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // CatagoryDetailsViewController
        if segue.identifier == "loadDatabase" {
            let categoryViewController: CategoryViewController = segue.destination as! CategoryViewController
            categoryViewController.dict = dictViewCont
            categoryViewController.categories = categoryViewCont
            categoryViewController.database = database
        }
        // SpeechViewControlller
        if segue.identifier == "loadSpeechDatabase" {
            let speechViewController: SpeechViewController = segue.destination as! SpeechViewController
            
            speechViewController.allWords = allWords
            speechViewController.codeDict = codeDict
        }
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = foodData().loadFoodDatabase()!
        dictViewCont = foodData().categorizeItems()
        categoryViewCont = foodData().categorizeItems().keys.sorted(by: <)
        allWords = BagOfWord().loadAllWords()
        codeDict = BagOfWord().loadDictionary()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testingTapped(_ sender: UIButton) {
        let diary = NutrientDiaryCoreDataHandler.fetchObject()!
        if diary.count != 0 {
            for eachItem in diary{
                print("GJ: date: \(String(describing: eachItem.date)), food (\(String(describing: eachItem.foodname)), amount: \(eachItem.amount)")
            }
        }
        
        
    }

    
}

