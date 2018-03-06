//
//  File.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 05/03/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import Foundation
import CoreData
import MessageUI

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
    
}
