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
        let entity = NSEntityDescription.entity(forEntityName: "NutrientToView", in: context) //"Nutrient" comes from the .xcdatamodeled file
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
    class func changeSelection(nutrientToView: NutrientToView, select: Int16) {
        let context = getContext()
        
        nutrientToView.select = select
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with changing core data - NutrientToView")
        }
        
    }
    
    //fetch object
    class func fetchObject() -> [NutrientToView]?{
        let context = getContext()
        var nutrientToView:[NutrientToView] = []
        do {
            nutrientToView = try context.fetch(NutrientToView.fetchRequest())
            return nutrientToView
        } catch {
            print("GJ: Something goes wrong with fetching core data - NutrientToView")
            return nutrientToView // will be nil if things go wrong
        }
    }
    
    
    //delete object
    class func deleteObject(nutrientToView: NutrientToView) {
        let context = getContext()
        context.delete(nutrientToView)
        
        do {
            try context.save()
        } catch {
            print("GJ: Something goes wrong with deleting core data - NutrientToView")
        }
    }
    
    //clean delete
    class func clearnDelete(){
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: NutrientToView.fetchRequest())
        
        do{
            try context.execute(delete)
        } catch {
            print("GJ: Something goes wrong with deleting core data - NutrientToView")
        }
    }
}


