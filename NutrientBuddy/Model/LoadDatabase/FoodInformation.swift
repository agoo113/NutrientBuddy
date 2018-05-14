//
//  FoodInformation.swift
//  DemoSearch
//
//  Created by Gemma Jing on 11/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit
// MARK: struc to save all food information
// there are 2897 food items
struct FoodInfo: Decodable {
    init(){
        Food_Name = "non"
        Water_g = 0
        Protein_g = 0
        Fat_g = 0
        Carbohydrate_g = 0
        Sugar_g = 0
        NSP_g = 0
        Energy_kcal = 0
        AOAC_fibre_g = 0
        Sodium_mg = 0
        Potassium_mg = 0
        Calcium_mg = 0
        Magnesium_mg = 0
        Phosphorus_mg = 0
        Iron_mg = 0
        Copper_mg = 0
        Zinc_mg = 0
        Chloride_mg = 0
        Manganese_mg = 0
        Selenium_microg = 0
        Iodine_microg = 0
        Retinol_microg = 0
        Carotene_microg = 0
        Retinol_Equivalent_microg = 0
        Vitamin_D_microg = 0
        Vitamin_E_mg = 0
        Vitamin_K1_microg = 0
        Thiamin_mg = 0
        Riboflavin_mg = 0
        Niacin_mg = 0
        TryptophanP60_mg = 0
        NiacinEquivalent_mg = 0
        Vitamin_B6_mg = 0
        Vitamin_B12_microg = 0
        Folate_microg = 0
        Pantothenate_mg = 0
        Biotin_microg = 0
        Vitamin_C_mg = 0
        Minerals_mg = 0
        Vitamin_mg = 0
        //NewTotal = 0
    }
    var Food_Name: String
    let Water_g: Double
    let Protein_g: Double
    let Fat_g: Double
    let Carbohydrate_g: Double
    let Sugar_g: Double
    let NSP_g: Double
    let Energy_kcal: Double
    let AOAC_fibre_g: Double
    let Sodium_mg: Double
    let Potassium_mg: Double
    let Calcium_mg: Double
    let Magnesium_mg: Double
    let Phosphorus_mg: Double
    let Iron_mg: Double
    let Copper_mg: Double
    let Zinc_mg: Double
    let Chloride_mg: Double
    let Manganese_mg: Double
    let Selenium_microg: Double
    let Iodine_microg: Double
    let Retinol_microg: Double
    let Carotene_microg: Double
    let Retinol_Equivalent_microg: Double
    let Vitamin_D_microg: Double
    let Vitamin_E_mg: Double
    let Vitamin_K1_microg: Double
    let Thiamin_mg: Double
    let Riboflavin_mg: Double
    let Niacin_mg: Double
    let TryptophanP60_mg: Double
    let NiacinEquivalent_mg: Double
    let Vitamin_B6_mg: Double
    let Vitamin_B12_microg: Double
    let Folate_microg: Double
    let Pantothenate_mg: Double
    let Biotin_microg: Double
    let Vitamin_C_mg: Double
    let Minerals_mg: Double
    let Vitamin_mg: Double
    //let NewTotal: Double
};

class foodInformation {
    var nutrientType: String
    var amount: Double
    var unit: String
    
    init?(nutrientType: String, amount: Double, unit: String) {
        if nutrientType.isEmpty {
            return nil
        }
        
        self.nutrientType = nutrientType
        self.amount = amount
        self.unit = unit
    }
}
