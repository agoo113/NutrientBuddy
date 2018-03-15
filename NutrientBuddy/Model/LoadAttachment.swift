//
//  File.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 05/03/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import Foundation
import CoreData

class LoadAttachment {
    func writeCoreDataObjToCSV(object:[NSManagedObject], named: String) -> String {
        guard object.count > 0 else{
              return "errorLoadingCSV"
        }
        
        let firstObject = object[0]
        let attribs = Array(firstObject.entity.attributesByName.keys)
        let csvHeaderString = (attribs.reduce("", {($0 as String) + "," + $1}) as NSString).substring(from: 1) + "\n"
        let csvArray = object.map({object in
            (attribs.map({((object.value(forKey: $0) ?? "nil") as AnyObject).description}).reduce("", {$0 + "," + $1}) as NSString).substring(from: 1) + "\n"
        })
        let csvString = csvArray.reduce("", +)
        return csvHeaderString + csvString
    }
    
    func feedBackQuestions() -> String {
        var content: String
        content = "1. What goal do you wish to accomplish with NutrientBuddy? \n\n\n"
        content.append("2. Is NutrientBuddy motivational enough to assist you in accomplishing the goal? \n\n\n")
        content.append("3. Were you able to find most food you consumed with NutrientBuddy? What kind of food can you not find? \n\n\n")
        content.append("4. How do you like the nutrient visualisation in Home view? Is there any other nutrients you would like to visualise? \n\n\n")
        content.append("5. How was your experience to find food? Is that easy enough to figure out where to go? And did you know that you can set your own nutrient goal? \n\n\n")
        content.append("6. Did you know that you can view more nutrients types? \n\n\n")
        content.append("7. Did you know that you can browse through our whole database? \n\n\n")
        content.append("8. What are the features of NutrientBuddy that you do not like? \n\n\n")
        content.append("9. What are the features of NutrientBuddy that you like? \n\n\n")
        content.append("10. Please rate 1-10, your experience with logging meals. Any comments? \n\n\n")
        content.append("11. Please rate 1-10, the vitual of home page. Is the graphics understandable? Any comments? \n\n\n")
        content.append("12. Please rate 1-10, your experience with NutrientBuddy? Any comments? \n\n\n")
        return content
    }
}
