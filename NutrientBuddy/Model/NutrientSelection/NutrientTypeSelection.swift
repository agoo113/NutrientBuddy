//
//  NutrientTypeSelection.swift
//  DemoSearch
//
//  Created by Gemma Jing on 29/01/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import Foundation
import CoreData

class NutrientSelectionSetting {
    
    // MARK: set default to nutrient type core data
    func setSelectionDefault(selectedFoodInfo: FoodInfo) {
        // default only display the first 5 nutrients in the database: "Water", "Fat", "Protein", "Carbohydrate", "NSP"
        var cd_selections: [Int16] = []
        let cd_nutrientTypes = ["Water", "Fat", "Protein", "Carbohydrate", "NSP", "Energy", "AOAC fibre","Sodium", "Potassium", "Calcium", "Magnesium", "Phosphorus", "Iron", "Copper", "Zinc", "Chloride", "Manganese", "Selenium", "Iodine", "Retinol", "Carotene", "Retinol Equivalent", "Vitamin_D", "Vitamin_E", "Vitamin_K1", "Thiamin", "Riboflavin", "Niacin", "TryptophanP60", "Niacin Equivalent", "Vitamin_B6", "Vitamin_B12", "Folate", "Pantothenate", "Biotin", "Vitamin_C", "Mineral(total)", "Vitamin(total)"]
        
        let cd_units = ["(g)", "(g)", "(g)", "(g)", "(g)", "(kcal)","(g)", "(mg)", "(mg)","(mg)","(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(μg)", "(μg)", "(μg)", "(μg)", "(μg)", "(μg)", "(mg)", "(μg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(μg)", "(μg)", "(mg)", "(μg)", "(mg)", "(mg)", "(mg)"]
        let cd_nutrientAmount = [selectedFoodInfo.Water_g, selectedFoodInfo.Fat_g, selectedFoodInfo.Protein_g, selectedFoodInfo.Carbohydrate_g, selectedFoodInfo.NSP_g, selectedFoodInfo.Energy_kcal, selectedFoodInfo.AOAC_fibre_g, selectedFoodInfo.Sodium_mg, selectedFoodInfo.Potassium_mg, selectedFoodInfo.Calcium_mg, selectedFoodInfo.Magnesium_mg, selectedFoodInfo.Phosphorus_mg, selectedFoodInfo.Iron_mg, selectedFoodInfo.Copper_mg, selectedFoodInfo.Zinc_mg, selectedFoodInfo.Chloride_mg, selectedFoodInfo.Manganese_mg, selectedFoodInfo.Selenium_microg, selectedFoodInfo.Iodine_microg, selectedFoodInfo.Retinol_microg, selectedFoodInfo.Carotene_microg, selectedFoodInfo.Retinol_Equivalent_microg, selectedFoodInfo.Vitamin_D_microg, selectedFoodInfo.Vitamin_E_mg, selectedFoodInfo.Vitamin_K1_microg, selectedFoodInfo.Thiamin_mg, selectedFoodInfo.Riboflavin_mg, selectedFoodInfo.Niacin_mg, selectedFoodInfo.TryptophanP60_mg, selectedFoodInfo.NiacinEquivalent_mg, selectedFoodInfo.Vitamin_B6_mg, selectedFoodInfo.Vitamin_B12_microg, selectedFoodInfo.Folate_microg, selectedFoodInfo.Pantothenate_mg, selectedFoodInfo.Biotin_microg, selectedFoodInfo.Vitamin_C_mg, selectedFoodInfo.Minerals_mg, selectedFoodInfo.Vitamin_mg]
        
        while cd_selections.count < 5 {
            cd_selections.append(1)
        }
        while cd_selections.count < 38 {
            cd_selections.append(0)
        }
        
        // Add in core data
        for i in 0...37 {
            NutrientTypeCoreDataHandler.saveObject(type: cd_nutrientTypes[i], select: cd_selections[i], unit: cd_units[i], amount: cd_nutrientAmount[i])
        }
        print("GJ: saved default settings")
    }
}
