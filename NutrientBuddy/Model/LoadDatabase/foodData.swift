//
//  foodNutrientsStruct.swift
//  StructureData
//
//  Created by Gemma Jing on 20/10/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import Foundation
//MARK: building database

class foodData{
    // MARK: formatting the json text
    // To modify the original string to readable JSON:
    // 1. Change "null" to 0
    // 2. Remove "\n  ", "\n", " }", space after ": " and change other " " to "_"
    // 3. Add on "}" for all
    // 4. Delete the comma if there is one at the start
    func formatForJson(contents: String) -> [String]?{
        let content_null = contents.replacingOccurrences(of: "null", with: "0")
        let lines = content_null.split(separator: "}", maxSplits: 2897, omittingEmptySubsequences: true)
        
        var jsonString : [String] = []
        
        for element in lines{
            let mod_line_trim = element.trimmingCharacters(in: .whitespacesAndNewlines)
            var mod_line_n = mod_line_trim.replacingOccurrences(of: "\n   ", with: "")
            mod_line_n = mod_line_n.replacingOccurrences(of: "\n", with: "")
            mod_line_n = mod_line_n.replacingOccurrences(of: "\r", with: "")
            let mod_line_back_bracket = mod_line_n.replacingOccurrences(of: " }", with: "}")
            let mod_line_col = mod_line_back_bracket.replacingOccurrences(of: ": ", with: ":")
            let mod_line_space = mod_line_col.replacingOccurrences(of: " ", with: "_")
            
            var mod_line_bracket = mod_line_space
            if mod_line_space.last != "}"{
                mod_line_bracket += "}"
            }
            
            //check if the first character is a comma and remove it
            if element.first == ","{
                mod_line_bracket.removeFirst()
                mod_line_bracket.removeFirst()
            }
            jsonString.append(mod_line_bracket)
        }
        return jsonString
    }

    // MARK: load json text file in an array of struct -- database
    // Singulize all the food item names
    func loadFoodDatabase() -> [FoodInfo]?{
        let path = Bundle.main.path(forResource: "datasetJSON", ofType: "json")
        var contents: String?
        try! contents = String(contentsOfFile: path!)
        let jsonString = formatForJson(contents: contents!)
        var database: [FoodInfo] = []
        
        let decoder = JSONDecoder()
        for singleString in jsonString!{
            let jsonData = singleString.data(using: .utf8)!
            var food = try! decoder.decode(FoodInfo.self, from: jsonData)
            food.Food_Name = singulize(food_name: food.Food_Name)
            database.append(food)
        }
        return database
    }
    
    // MARK: load food item names in a dictionary
    // [nameWithoutComma: nameWithComma]
    func loadFoodNames() -> [String: String] {
        let database = loadFoodDatabase()
        var foodNameData:[String: String] = [:]
        
        for item in database! {
            let name = item.Food_Name.replacingOccurrences(of: "_", with: " ")
            let key = name.replacingOccurrences(of: ",", with: "")
            foodNameData[key] = name
        }
        
        return foodNameData
    }
    
    // MARK: categorize the food items
    func categorizeItems() ->[String:[String]]{
        let foodNameDic = loadFoodNames()
        var foodNameData: [String] = []
        let sortedFoodNameDic = foodNameDic.sorted(by: <)
        for (_, value) in sortedFoodNameDic {
            foodNameData.append(value)
        }
        var categorizedFoodItem: [String: [String]] = [:]
        var category: String = ""
        
        for item in foodNameData {
            let array = item.split(separator: ",")
            if category != String(array[0]){
                category = String(array[0])
                categorizedFoodItem[category] = []
            }
            categorizedFoodItem[category]?.append(item)
        }
        return categorizedFoodItem
    }
    
    // MARK: 1st search from the database time input form the user:  foodToSearch
    func searchItem(foodToSearch: String) -> [FoodInfo?]{
        var database: [FoodInfo] = []
        database = loadFoodDatabase()!
        var itemTargeted: [FoodInfo] = []
        
        let dataSize = database.count
        var i = 0
        
        while i < dataSize{
            let item = database[i]
            if (item.Food_Name.range(of: foodToSearch) != nil){
                itemTargeted.append(item)
            }
            i = i + 1
        }
        return itemTargeted
    }
    
    //Mark: singulize the food item name
    func singulize(food_name: String)-> String {
        let breakdown = food_name.split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
        let original_food_name = String(breakdown[0])
        var array = Array(original_food_name)
        let length = original_food_name.count
        
        
        if array[length - 1] == "s" {
            if array[length - 2] != "s" {
                array.removeLast()
                if array[length - 2] == "e" && array[length - 3] == "i" {
                    if original_food_name != "juice" {
                        array.removeLast()
                        array.removeLast()
                        array.append("y")
                    }
                }
            }
        }
        var single_food_name = String(array)
        if breakdown.count == 2 {
            single_food_name += ","
            single_food_name += String(breakdown[1])
        }
        return single_food_name
    }

}
