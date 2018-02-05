//
//  BagOfWords.swift
//  StructureData
//
//  Created by Gemma Jing on 02/12/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import Foundation

class BagOfWord {
    //MARK: load all words in a string array -- word collection
    func loadAllWords() -> [String]{
        var wordsInNames: [String] = []
        let foodNames = foodData().loadFoodNames().keys
        for names in foodNames{
            let split = names.split(separator: ",")
            for wordString in split{
                let split2 = String(wordString).split(separator: " ")
                for word in split2{
                    if !wordsInNames.contains(String(word)){
                        wordsInNames.append(String(word).lowercased()) //add word in the allWord 
                    }
                }
            }
        }
        return wordsInNames
    }
    
    //MARK: load dictionary of all food item names - string with encoded names
    func loadDictionary() -> [String: [Int]]{
        var foodItemNamesCodeDictNoComma: [String: [Int]] = [:]
        
        let allWords = loadAllWords()
        let foodNamesDic = foodData().loadFoodNames()
        let foodNames = foodNamesDic.keys
        
        for name in foodNames{
            var indexArray: [Int] = []
            let split = name.split(separator: " ")
            for word in split{
                let id = allWords.index(of: String(word).lowercased())!
                indexArray.append(id)
            }
            foodItemNamesCodeDictNoComma.updateValue(indexArray, forKey: name)
        }
        // sort the dictionary
        //let sortedFoodItemNameCodeDictNoComma = Array(foodItemNamesCodeDictNoComma.sorted(by:{$0.key < $1.key}))
        
        
        return foodItemNamesCodeDictNoComma
    }
    
    //MARK: encode the search string
    func encodeSearchString(searchStr: String) -> Set<Int>{
        let allWords = loadAllWords()
        var codedSearch = Set<Int>()
        
        let split = searchStr.split(separator: " ")
        for word in split{
            if allWords.contains(String(word)) {
                let id = allWords.index(of: String(word))
                codedSearch.insert(id!)
            }
        }
        return codedSearch
    }

}
