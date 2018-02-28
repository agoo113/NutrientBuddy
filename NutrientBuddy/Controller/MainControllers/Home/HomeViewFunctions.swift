//
//  HomeViewFunctions.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 27/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

struct percentageConsumed {
    var waterPercentage: Double
    var proteinPercentage: Double
    var fatPercentage: Double
    var carboPercentage: Double
    var energyPercentage: Double
    
    init() {
        waterPercentage = 0.0
        proteinPercentage = 0.0
        fatPercentage = 0.0
        carboPercentage = 0.0
        energyPercentage = 0.0
    }
};


class HomeViewFunctions {
    func getNutrientToView(nutrientToView:
        [NutrientToView]) -> [NutrientToView]{
         let selectedFoodInfo = FoodInfo()
        if nutrientToView.count != 38 {
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
                    nutrientToAppend = foodInformation(nutrientType: singleNutrient.type!, amount: amount, unit: "(g)")!
                }
                else{
                    nutrientToAppend = foodInformation(nutrientType: singleNutrient.type!, amount: 0, unit: "(g)")!
                }
                displayNutrient.append(nutrientToAppend)
            }
        }
        return displayNutrient
    }
    
    func loadSummaryAndPercentages(waterGoal: Double, energyGoal: Double, date: String) -> (summary: Summary, percentages: percentageConsumed) {
        let summary = NutrientDiary().updateNutrientsSummaryOfTheDay(date: date)
        var percentages = percentageConsumed()
        if summary.date != nil{
            percentages.waterPercentage = summary.water/waterGoal
            percentages.energyPercentage = (summary.energy)/(energyGoal)
            let totalOfThree = summary.fat + summary.carbohydrate + summary.protein
            percentages.proteinPercentage = (summary.protein)/totalOfThree
            percentages.fatPercentage = (summary.fat)/totalOfThree
            percentages.carboPercentage = (summary.carbohydrate)/totalOfThree
            
            if debugHomeView {
                 print("GJ: cunsumed water \(percentages.waterPercentage) g, protein \(percentages.proteinPercentage), fat \(percentages.fatPercentage), carbo \(percentages.energyPercentage)")
            }
        }
        return (summary, percentages)
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
