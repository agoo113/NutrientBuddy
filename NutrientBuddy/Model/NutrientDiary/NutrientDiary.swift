//
//  NutrientDiary.swift
//  DemoSearch
//
//  Created by Gemma Jing on 02/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import Foundation

class NutrientDiary {
    //MARK: get date (dd/mm/yyyy)
    func getDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        return dateFormatter.string(from: date)
    }
    //MARK: save diary with amount
    func saveDiaryToCoredata(savedFood: FoodInfo, amount: Double, typeOfMeal: String){
        let date = getDate() // saved as 26/02/2018 e.g
        let water = savedFood.Water_g * amount/100
        let fat = savedFood.Fat_g * amount/100
        let protein = savedFood.Protein_g * amount/100
        let carbohydrate = savedFood.Carbohydrate_g * amount/100
        let sugar = savedFood.Sugar_g * amount/100
        let nsp = savedFood.NSP_g  * amount/100
        let energy = savedFood.Energy_kcal * amount/100
        let aoac_fibre = savedFood.AOAC_fibre_g * amount/100
        let sodium = savedFood.Sodium_mg  * amount/100000
        let potassium = savedFood.Potassium_mg  * amount/100000
        let calcium = savedFood.Calcium_mg  * amount/100000
        let magnesium = savedFood.Magnesium_mg  * amount/100000
        let phosphorus = savedFood.Phosphorus_mg  * amount/100000
        let iron = savedFood.Iron_mg * amount/100000
        let copper = savedFood.Copper_mg * amount/100000
        let zinc = savedFood.Zinc_mg * amount/100000
        let chloride = savedFood.Chloride_mg * amount/100000
        let manganese = savedFood.Manganese_mg * amount/100000
        let selenium = savedFood.Selenium_microg * amount/100000000
        let iodine = savedFood.Iodine_microg * amount/100000000
        let retinol = savedFood.Retinol_microg * amount/100000000
        let carotene = savedFood.Carotene_microg * amount/100000000
        let retinol_equivalent = savedFood.Retinol_Equivalent_microg * amount/100000000
        let vitamin_d = savedFood.Vitamin_D_microg * amount/100000000
        let vitamin_e = savedFood.Vitamin_E_mg * amount/100000
        let vitamin_k1 = savedFood.Vitamin_K1_microg * amount/100000000
        let thiamin = savedFood.Thiamin_mg * amount/100000
        let riboflavin = savedFood.Riboflavin_mg * amount/100000
        let niacin = savedFood.Niacin_mg * amount/100000
        let tryptophan_p60 = savedFood.TryptophanP60_mg * amount/100000
        let niacin_equivalent = savedFood.NiacinEquivalent_mg * amount/100000
        let vitamin_b6 = savedFood.Vitamin_B6_mg * amount/100000
        let vitamin_b12 = savedFood.Vitamin_B12_microg * amount/100000000
        let folate = savedFood.Folate_microg * amount/100000000
        let pantothenate = savedFood.Pantothenate_mg * amount/100000
        let biotin = savedFood.Biotin_microg * amount/100000000
        let vitamin_c = savedFood.Vitamin_C_mg * amount/100000
        let minerals_total = savedFood.Minerals_mg * amount/100000
        let vitamin_total = savedFood.Vitamin_mg * amount/100000
        
        let nameString = savedFood.Food_Name.replacingOccurrences(of: ",", with: "")
        NutrientDiaryCoreDataHandler.saveObject(date: date, typeOfMeal: typeOfMeal, foodname: nameString, amount: amount, water: water, fat: fat, protein: protein, carbohydrate: carbohydrate, sugar: sugar, nsp: nsp, energy: energy, aoac_fibre: aoac_fibre, sodium: sodium, potassium: potassium, calcium: calcium, magnesium: magnesium, phosphorus: phosphorus, iron: iron, copper: copper, zinc: zinc, chloride: chloride, manganese: manganese, selenium: selenium, iodine: iodine, retinol: retinol, carotene: carotene, retinol_equivalent: retinol_equivalent, vitamin_d: vitamin_d, vitamin_e: vitamin_e, vitamin_k1: vitamin_k1, thiamin: thiamin, riboflavin: riboflavin, niacin: niacin, tryptophan_p60: tryptophan_p60, niacin_equivalent: niacin_equivalent, vitamin_b6: vitamin_b6, vitamin_b12: vitamin_b12, folate: folate, pantothenate: pantothenate, biotin: biotin, vitamin_c: vitamin_c, mineral_total: minerals_total, vitamin_total: vitamin_total)
        
    }
    // MARK: save summary
    func updateNutrientsSummaryOfTheDay(date: String) -> Summary{
        //get diary of the same date
        let diary = NutrientDiaryCoreDataHandler.fetchObject()!
        let diaryOfDate = diary.filter { $0.date == date }
       
        //get initialized summary
        let summary = initialiseSummary(date: date)
        if diaryOfDate.count == 0 {
            return summary
        }
        
        for each in diaryOfDate {
            if debugHomeView {
                print("GJ: food loged on \(date): - NutrientDiary")
                print(each)
            }
            summary.aoac_fibre += each.aoac_fibre
            summary.biotin += each.biotin
            summary.calcium += each.calcium
            summary.carbohydrate += each.carbohydrate
            summary.sugar += each.sugar
            summary.carotene += each.carotene
            summary.chloride += each.chloride
            summary.copper += each.copper
            summary.energy += each.energy
            summary.fat += each.fat
            summary.folate += each.folate
            summary.iodine += each.iodine
            summary.iron += each.iron
            summary.magnesium += each.magnesium
            summary.manganese += each.manganese
            summary.mineral_total += each.mineral_total
            summary.niacin += each.niacin
            summary.niacin_equivalent += each.niacin_equivalent
            summary.nsp += each.nsp
            summary.pantothenate += each.pantothenate
            summary.phosphorus += each.phosphorus
            summary.potassium += each.potassium
            summary.protein += each.protein
            summary.retinol += summary.retinol
            summary.retinol_equivalent += summary.retinol_equivalent
            summary.riboflavin += each.riboflavin
            summary.selenium += each.selenium
            summary.sodium += each.sodium
            summary.thiamin += each.thiamin
            summary.tryptophan_p60 += each.tryptophan_p60
            summary.vitamin_b12 += each.vitamin_b12
            summary.vitamin_c += each.vitamin_c
            summary.vitamin_d += each.vitamin_d
            summary.vitamin_e += each.vitamin_e
            summary.vitamin_b6 += each.vitamin_b6
            summary.vitamin_k1 += each.vitamin_k1
            summary.vitamin_total += each.vitamin_total
            summary.water += each.water
            summary.zinc += each.zinc
        }
        summary.totalWeight = summary.aoac_fibre + summary.water + summary.protein + summary.protein + summary.fat + summary.carbohydrate + summary.nsp
        if debugHomeView {
            print("GJ: summary of food is - NutrientDiary")
            print(summary)
        }
        
        SummaryDiaryCoreDataHandler.saveObject(summary: summary)
        if debugHomeView {
             print("GJ: saved new summary at \(date), total weight is \(summary.totalWeight) grams - NutrientDiary")
        }
        
        return summary
    }
    private func initialiseSummary(date: String) -> Summary {
        SummaryDiaryCoreDataHandler.saveInitialObject(date: date, typeOfMeal: "unknown", totalWeight: 0, water: 0, fat: 0, protein: 0, carbohydrate: 0, sugar: 0, nsp: 0, energy: 0, aoac_fibre: 0, sodium: 0, potassium: 0, calcium: 0, magnesium: 0, phosphorus: 0, iron: 0, copper: 0, zinc: 0, chloride: 0, manganese: 0, selenium: 0, iodine: 0, retinol: 0, carotene: 0, retinol_equivalent: 0, vitamin_d: 0, vitamin_e: 0, vitamin_k1: 0, thiamin: 0, riboflavin: 0, niacin: 0, tryptophan_p60: 0, niacin_equivalent: 0, vitamin_b6: 0, vitamin_b12: 0, folate: 0, pantothenate: 0, biotin: 0, vitamin_c: 0, mineral_total: 0, vitamin_total: 0)
            let summary = SummaryDiaryCoreDataHandler.fetchObject(date: date)
        return summary.last!
    }
}
