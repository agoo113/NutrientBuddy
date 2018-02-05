//
//  NutrientDiary.swift
//  DemoSearch
//
//  Created by Gemma Jing on 02/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import Foundation

class NutrientDiary {
    func saveDiaryToCoredata(savedFood: FoodInfo, amount: Double){
        let date = Date()
        let water = savedFood.Water_g * amount/100
        let fat = savedFood.Fat_g * amount/100
        let protein = savedFood.Protein_g * amount/100
        let carbohydrate = savedFood.Carbohydrate_g * amount/100
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
        
        NutrientDiaryCoreDataHandler.saveObject(date: date, foodname: savedFood.Food_Name, amount: amount, water: water, fat: fat, protein: protein, carbohydrate: carbohydrate, nsp: nsp, energy: energy, aoac_fibre: aoac_fibre, sodium: sodium, potassium: potassium, calcium: calcium, magnesium: magnesium, phosphorus: phosphorus, iron: iron, copper: copper, zinc: zinc, chloride: chloride, manganese: manganese, selenium: selenium, iodine: iodine, retinol: retinol, carotene: carotene, retinol_equivalent: retinol_equivalent, vitamin_d: vitamin_d, vitamin_e: vitamin_e, vitamin_k1: vitamin_k1, thiamin: thiamin, riboflavin: riboflavin, niacin: niacin, tryptophan_p60: tryptophan_p60, niacin_equivalent: niacin_equivalent, vitamin_b6: vitamin_b6, vitamin_b12: vitamin_b12, folate: folate, pantothenate: pantothenate, biotin: biotin, vitamin_c: vitamin_c, mineral_total: minerals_total, vitamin_total: vitamin_total)
        
    }
}
