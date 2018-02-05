//
//  NutrientTypeCoreDataHandler.swift
//  DemoSearch
//
//  Created by Gemma Jing on 27/01/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import CoreData

class NutrientTypeCoreDataHandler: NSObject {
    
    //get object
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //save object
    class func saveObject(type: String, select: Int16, unit: String, amount:Double) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Nutrient", in: context) //"Nutrient" comes from the .xcdatamodeled file
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(type, forKey: "type")
        manageObject.setValue(select, forKey: "select")
        manageObject.setValue(unit, forKey: "unit")
        manageObject.setValue(amount, forKey: "amount")
        //save the context
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with saving core data")
        }
    }
    
    //change object selection
    class func changeSelection(nutrient: Nutrient, select: Int16) {
        let context = getContext()
        
        nutrient.select = select
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with changing core data - Nutrient")
        }
        
    }
    
    //fetch object
    class func fetchObject() -> [Nutrient]?{
        let context = getContext()
        var nutrient:[Nutrient] = []
        do {
            nutrient = try context.fetch(Nutrient.fetchRequest())
            return nutrient
        } catch {
            print("GJ: Something goes wrong with fetching core data - Nutrient")
            return nutrient // will be nil if things go wrong
        }
    }
    
    
    //delete object
    class func deleteObject(nutrient: Nutrient) {
        let context = getContext()
        context.delete(nutrient)
        
        do {
            try context.save()
        } catch {
            print("GJ: Something goes wrong with deleting core data - Nutrient")
        }
    }
    
    //clean delete
    class func clearnDelete(){
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Nutrient.fetchRequest())
        
        do{
            try context.execute(delete)
        } catch {
            print("GJ: Something goes wrong with deleting core data - Nutrient")
        }
    }
}


