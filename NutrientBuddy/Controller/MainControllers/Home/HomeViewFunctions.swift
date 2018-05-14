//
//  HomeViewFunctions.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 27/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

struct percentageConsumedForRings {
    var proteinPercentage: Double
    var fatPercentage: Double
    var carboPercentage: Double
    var energyPercentage: Double
    
    init() {
        proteinPercentage = 0.0
        fatPercentage = 0.0
        carboPercentage = 0.0
        energyPercentage = 0.0
    }
};

struct percentageConsumedForBars{
    var waterGlassesConsumed: Double
    var waterGlassesGoal: Double
    var sugarPercentage: Double
    var vitaminCPercentage: Double
    
    init() {
        waterGlassesConsumed = 0.0
        waterGlassesGoal = 0.0
        sugarPercentage = 0.0
        vitaminCPercentage = 0.0
    }
};

class HomeViewFunctions {
    func getNutrientToView(nutrientToView:
        [NutrientToView]) -> [NutrientToView]{
         let selectedFoodInfo = FoodInfo()
        if nutrientToView.count != 39 {
            NutrientTypeCoreDataHandler.clearnDelete()
            NutrientSelectionSetting().setSelectionDefault(selectedFoodInfo: selectedFoodInfo)
            let newNutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
            return newNutrientToView
        }
        else{
            return nutrientToView
        }
    }
    
    func loadFoodNutrition(nutrientToView: [NutrientToView], summary: Summary, date: String) -> [foodInformation] {
        var displayNutrient: [foodInformation] = []
        var nutrientToAppend: foodInformation
        
        var summaryExist = true
        if summary.date == nil{
            summaryExist = false
        }
        
        for singleNutrient in nutrientToView {
            if singleNutrient.select == 1 {
                if summaryExist {
                    let amount = NutrientSelectionSetting().getSummaryAmount(type: singleNutrient.type!, date: date, summary:summary)
                    var unit = "(g)"
                    if singleNutrient.type == "Energy" {
                        unit = "(Kcal)"
                    }
                    if singleNutrient.type == "Water" {
                        unit = "(ml)"
                    }
                    nutrientToAppend = foodInformation(nutrientType: singleNutrient.type!, amount: amount, unit: unit)!
                }
                else{
                    nutrientToAppend = foodInformation(nutrientType: singleNutrient.type!, amount: 0, unit: "(g)")!
                }
                displayNutrient.append(nutrientToAppend)
            }
        }
        return displayNutrient
    }
    
    func loadSummaryAndPercentages(waterGoal: Double, energyGoal: Double, date: String, carboGoal: Double, proteinGoal: Double, vitaminCGoal: Double, fatGoal: Double, sugarGoal: Double) -> (summary: Summary, ringsPercentage: percentageConsumedForRings, barsPercentage: percentageConsumedForBars) {
        
        let summary = NutrientDiary().updateNutrientsSummaryOfTheDay(date: date)
        var ringsPercentage = percentageConsumedForRings()
        var barPercentage = percentageConsumedForBars()
        
        let threeTotalGoal = carboGoal + fatGoal + proteinGoal
        let carboPro = carboGoal/threeTotalGoal
        let fatPro = fatGoal/threeTotalGoal
        let proteinPro = proteinGoal/threeTotalGoal
        
        let totalCarboGoal = carboPro * energyGoal / 4.0
        let totalFatGoal = fatPro * energyGoal / 9.0
        let totalProteinGoal = proteinPro * energyGoal / 4.0
        if summary.date != nil{
            barPercentage.waterGlassesConsumed = summary.water/240
            barPercentage.waterGlassesGoal = waterGoal
            barPercentage.vitaminCPercentage = summary.vitamin_c/(vitaminCGoal*0.001)
            barPercentage.sugarPercentage = summary.sugar/sugarGoal
            
            ringsPercentage.energyPercentage = summary.energy/energyGoal
            
            if debugHomeView {
                print(summary)
            }
            
            ringsPercentage.carboPercentage = summary.carbohydrate / totalCarboGoal
            ringsPercentage.fatPercentage = summary.fat / totalFatGoal
            ringsPercentage.proteinPercentage = summary.protein / totalProteinGoal
            
        }
        return (summary, ringsPercentage, barPercentage)
    }
    
    func deletePreviousNutrientSummaryIfExist(date: String) {
        let summary = SummaryDiaryCoreDataHandler.fetchObject(date: date)
        if summary.count > 1 {
            let numToDelete = summary.count - 2
            for i in 0...numToDelete {
                let delete = summary[i]
                if debugHomeView {
                     print("GJ: deleting OLD summary at \(date), total weight was \(String(describing: delete.totalWeight)) grams - NutrientDiary")
                }
                SummaryDiaryCoreDataHandler.deleteObject(summary: delete)
            }
        }
    }
}
