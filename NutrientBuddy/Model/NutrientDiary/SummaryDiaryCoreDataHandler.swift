//
//  SummaryDiaryCoreDataHandler.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 25/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import CoreData

class SummaryDiaryCoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK: save initial object
    class func saveInitialObject(date:String, totalWeight: Double, water:Double, fat:Double, protein:Double, carbohydrate:Double, nsp:Double, energy:Double, aoac_fibre:Double, sodium:Double, potassium:Double, calcium:Double, magnesium:Double, phosphorus:Double, iron:Double, copper:Double, zinc:Double, chloride:Double, manganese:Double, selenium:Double, iodine:Double, retinol:Double, carotene:Double, retinol_equivalent:Double, vitamin_d:Double, vitamin_e:Double, vitamin_k1:Double, thiamin:Double, riboflavin:Double, niacin:Double, tryptophan_p60:Double, niacin_equivalent:Double, vitamin_b6:Double, vitamin_b12:Double, folate:Double, pantothenate:Double, biotin:Double, vitamin_c:Double, mineral_total:Double, vitamin_total:Double){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Summary", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(date, forKey: "date")
        manageObject.setValue(totalWeight, forKey: "totalWeight")
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
            print("GJ: Something goes wrong with saving core data inital summary")
        }
    }
    
    //MARK: save summary of date
    class func saveObject(summary: Summary){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Summary", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(summary.date, forKey: "date")
        manageObject.setValue(summary.totalWeight, forKey: "totalWeight")
        manageObject.setValue(summary.water, forKey: "water")
        manageObject.setValue(summary.fat, forKey: "fat")
        manageObject.setValue(summary.protein, forKey: "protein")
        manageObject.setValue(summary.carbohydrate, forKey: "carbohydrate")
        manageObject.setValue(summary.nsp, forKey: "nsp")
        manageObject.setValue(summary.energy, forKey: "energy")
        manageObject.setValue(summary.aoac_fibre, forKey: "aoac_fibre")
        manageObject.setValue(summary.sodium, forKey: "sodium")
        manageObject.setValue(summary.potassium, forKey: "potassium")
        manageObject.setValue(summary.calcium, forKey: "calcium")
        manageObject.setValue(summary.magnesium, forKey: "magnesium")
        manageObject.setValue(summary.phosphorus, forKey: "phosphorus")
        manageObject.setValue(summary.iron, forKey: "iron")
        manageObject.setValue(summary.copper, forKey: "copper")
        manageObject.setValue(summary.zinc, forKey: "zinc")
        manageObject.setValue(summary.chloride, forKey: "chloride")
        manageObject.setValue(summary.manganese, forKey: "manganese")
        manageObject.setValue(summary.selenium, forKey: "selenium")
        manageObject.setValue(summary.iodine, forKey: "iodine")
        manageObject.setValue(summary.retinol, forKey: "retinol")
        manageObject.setValue(summary.carotene, forKey: "carotene")
        manageObject.setValue(summary.retinol_equivalent, forKey: "retinol_equivalent")
        manageObject.setValue(summary.vitamin_d, forKey: "vitamin_d")
        manageObject.setValue(summary.vitamin_e, forKey: "vitamin_e")
        manageObject.setValue(summary.vitamin_k1, forKey: "vitamin_k1")
        manageObject.setValue(summary.thiamin, forKey: "thiamin")
        manageObject.setValue(summary.riboflavin, forKey: "riboflavin")
        manageObject.setValue(summary.niacin, forKey: "niacin")
        manageObject.setValue(summary.tryptophan_p60, forKey: "tryptophan_p60")
        manageObject.setValue(summary.niacin_equivalent, forKey: "niacin_equivalent")
        manageObject.setValue(summary.vitamin_b6, forKey:"vitamin_b6")
        manageObject.setValue(summary.vitamin_b12, forKey: "vitamin_b12")
        manageObject.setValue(summary.folate, forKey: "folate")
        manageObject.setValue(summary.pantothenate, forKey: "pantothenate")
        manageObject.setValue(summary.biotin, forKey: "biotin")
        manageObject.setValue(summary.vitamin_c, forKey: "vitamin_c")
        manageObject.setValue(summary.mineral_total, forKey: "mineral_total")
        manageObject.setValue(summary.vitamin_total, forKey: "vitamin_total")
        
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with saving core data summary")
        }
    }
    //
    /*
    class func changeSelection(nutrientToView: NutrientToView, select: Int16) {
        let context = getContext()
        
        nutrientToView.select = select
        do{
            try context.save()
        } catch {
            print("GJ: Something goes wrong with changing core data - NutrientToView")
        }
        
    }*/
    //MARK: fetch object with date
    class func fetchObject(date: String) -> Summary?{
        let context = getContext()
        var summarys:[Summary] = []
        do {
            summarys = try context.fetch(Summary.fetchRequest())
            let summary = summarys.filter{$0.date == date}
            print("GJ: the summary is updated \(summary.count) times")
            return summary.last
        } catch {
            print("GJ: Something goes wrong with fetching core data - Summary")
            print("GJ: it could be that the summary with given date does not exist")
            return nil
        }
    }

    //delete object
    class func deleteObject(summary: Summary) {
        let context = getContext()
        context.delete(summary)
        
        do {
            try context.save()
        } catch {
            print("GJ: Something goes wrong with deleting core data - Summary on \(String(describing: summary.date))")
        }
    }
    
/*
    //clean delete
    class func clearnDelete(){
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Summary.fetchRequest())
        
        do{
            try context.execute(delete)
        } catch {
            print("GJ: Something goes wrong with deleting core data - Summary")
        }
    }
*/
}
