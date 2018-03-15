//
//  PersonalSettingCoreDataHandler.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 28/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import CoreData

class PersonalSettingCoreDataHandler: NSObject {
    
    //get object
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //save object
    class func saveObject(carboGoal: Double, energyGoal: Double, fatGoal: Double, proteinGoal: Double, vitaminCGoal: Double, sugarGoal:Double, waterGoal: Double) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Goals", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(sugarGoal, forKey: "sugar_goal")
        manageObject.setValue(vitaminCGoal, forKey: "vitamin_c_goal")
        manageObject.setValue(carboGoal, forKey: "carbo_goal")
        manageObject.setValue(energyGoal, forKey: "energy_goal")
        manageObject.setValue(fatGoal, forKey: "fat_goal")
        manageObject.setValue(proteinGoal, forKey: "protein_goal")
        manageObject.setValue(waterGoal, forKey: "water_goal")
    
        //save the context
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with saving core data - Goals")
        }
    }
    
    //change personal goals
    class func changeSelection(goals: Goals, waterGoal: Double, proteinGoal: Double, fatGoal: Double, energyGoal: Double, carboGoal: Double) {
        let context = getContext()
        
        goals.carbo_goal = carboGoal
        goals.energy_goal = energyGoal
        goals.fat_goal = fatGoal
        goals.protein_goal = proteinGoal
        goals.water_goal = waterGoal
        
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with changing core data - Goals")
        }
        
    }
    
    //fetch object
    class func fetchObject() -> [Goals]?{
        let context = getContext()
        var goal:[Goals] = []
        do {
            goal = try context.fetch(Goals.fetchRequest())
            return goal
        } catch {
            print("GJ: Something goes wrong with fetching core data - Goals")
            return goal
        }
    }
    
    //delete object
    class func deleteObject(goal: Goals) {
        let context = getContext()
        context.delete(goal)
        
        do {
            try context.save()
        } catch {
            print("GJ: Something goes wrong with deleting core data - Goals")
        }
    }
    //clean delete
    class func cleanDelete(){
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Goals.fetchRequest())
        
        do{
            try context.execute(delete)
        } catch {
            print("GJ: Something goes wrong with deleting core data - Goals")
        }
    }
}


