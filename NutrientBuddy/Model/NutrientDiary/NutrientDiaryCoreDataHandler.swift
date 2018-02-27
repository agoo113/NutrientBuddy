//
//  NutrientDiaryCoreDataHandler.swift
//  DemoSearch
//
//  Created by Gemma Jing on 02/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import CoreData

class NutrientDiaryCoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //save object
    class func saveObject(date:String, foodname:String, amount:Double, water:Double, fat:Double, protein:Double, carbohydrate:Double, nsp:Double, energy:Double, aoac_fibre:Double, sodium:Double, potassium:Double, calcium:Double, magnesium:Double, phosphorus:Double, iron:Double, copper:Double, zinc:Double, chloride:Double, manganese:Double, selenium:Double, iodine:Double, retinol:Double, carotene:Double, retinol_equivalent:Double, vitamin_d:Double, vitamin_e:Double, vitamin_k1:Double, thiamin:Double, riboflavin:Double, niacin:Double, tryptophan_p60:Double, niacin_equivalent:Double, vitamin_b6:Double, vitamin_b12:Double, folate:Double, pantothenate:Double, biotin:Double, vitamin_c:Double, mineral_total:Double, vitamin_total:Double) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Diary", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(date, forKey: "date")
        manageObject.setValue(amount, forKey: "amount")
        manageObject.setValue(foodname, forKey: "foodname")
        manageObject.setValue(water, forKey: "water")
        manageObject.setValue(fat, forKey: "fat")
        manageObject.setValue(protein, forKey: "protein")
        manageObject.setValue(carbohydrate, forKey: "carbohydrate")
        manageObject.setValue(nsp, forKey: "nsp")
        manageObject.setValue(energy, forKey: "energy")
        manageObject.setValue(aoac_fibre, forKey: "aoac_fibre")
        manageObject.setValue(sodium, forKey: "sodium")
        manageObject.setValue(potassium, forKey: "potassium")
        manageObject.setValue(calcium, forKey: "calcium")
        manageObject.setValue(magnesium, forKey: "magnesium")
        manageObject.setValue(phosphorus, forKey: "phosphorus")
        manageObject.setValue(iron, forKey: "iron")
        manageObject.setValue(copper, forKey: "copper")
        manageObject.setValue(zinc, forKey: "zinc")
        manageObject.setValue(chloride, forKey: "chloride")
        manageObject.setValue(manganese, forKey: "manganese")
        manageObject.setValue(selenium, forKey: "selenium")
        manageObject.setValue(iodine, forKey: "iodine")
        manageObject.setValue(retinol, forKey: "retinol")
        manageObject.setValue(carotene, forKey: "carotene")
        manageObject.setValue(retinol_equivalent, forKey: "retinol_equivalent")
        manageObject.setValue(vitamin_d, forKey: "vitamin_d")
        manageObject.setValue(vitamin_e, forKey: "vitamin_e")
        manageObject.setValue(vitamin_k1, forKey: "vitamin_k1")
        manageObject.setValue(thiamin, forKey: "thiamin")
        manageObject.setValue(riboflavin, forKey: "riboflavin")
        manageObject.setValue(niacin, forKey: "niacin")
        manageObject.setValue(tryptophan_p60, forKey: "tryptophan_p60")
        manageObject.setValue(niacin_equivalent, forKey: "niacin_equivalent")
        manageObject.setValue(vitamin_b6, forKey:"vitamin_b6")
        manageObject.setValue(vitamin_b12, forKey: "vitamin_b12")
        manageObject.setValue(folate, forKey: "folate")
        manageObject.setValue(pantothenate, forKey: "pantothenate")
        manageObject.setValue(biotin, forKey: "biotin")
        manageObject.setValue(vitamin_c, forKey: "vitamin_c")
        manageObject.setValue(mineral_total, forKey: "mineral_total")
        manageObject.setValue(vitamin_total, forKey: "vitamin_total")
        
        //save the context
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with saving core data")
        }
    }
  
    //fetch object
    class func fetchObject() -> [Diary]?{
        let context = getContext()
        var diary:[Diary] = []
        do {
            diary = try context.fetch(Diary.fetchRequest())
            return diary
        } catch {
            print("GJ: Something goes wrong with fetching core data - Diary")
            return diary // will be nil if things go wrong
        }
    }
    
    
    //delete object
    class func deleteObject(diary: Diary) {
        let context = getContext()
        context.delete(diary)
        
        do {
            try context.save()
        } catch {
            print("GJ: Something goes wrong with deleting core data - Diary")
        }
    }
    
    //clean delete
    class func clearnDelete(){
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Diary.fetchRequest())
        
        do{
            try context.execute(delete)
        } catch {
            print("GJ: Something goes wrong with deleting core data - Diary")
        }
    }
    
}
