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
        let cd_nutrientTypes = ["Energy", "Carbohydrate", "Protein", "Fat", "Water", "Vitamin C", "Sugar", "NSP", "AOAC Fibre","Sodium", "Potassium", "Calcium", "Magnesium", "Phosphorus", "Iron", "Copper", "Zinc", "Chloride", "Manganese", "Selenium", "Iodine", "Retinol", "Carotene", "Retinol Equivalent", "Vitamin D", "Vitamin E", "Vitamin K1", "Thiamin", "Riboflavin", "Niacin", "Tryptophan P60", "Niacin Equivalent", "Vitamin B6", "Vitamin B12", "Folate", "Pantothenate", "Biotin", "Mineral(total)", "Vitamin(total)"]
        let cd_units = ["(kcal)", "(g)", "(g)", "(g)", "(ml)" ,"(mg)", "(g)", "(g)", "(mg)", "(mg)","(mg)","(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(μg)", "(μg)", "(μg)", "(μg)", "(μg)", "(μg)", "(mg)", "(μg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(mg)", "(μg)", "(μg)", "(mg)", "(μg)", "(mg)", "(mg)", "(mg)"]
       
        let cd_nutrientAmount = [selectedFoodInfo.Energy_kcal, selectedFoodInfo.Carbohydrate_g, selectedFoodInfo.Protein_g, selectedFoodInfo.Fat_g, selectedFoodInfo.Water_g, selectedFoodInfo.Vitamin_C_mg, selectedFoodInfo.Sugar_g, selectedFoodInfo.NSP_g, selectedFoodInfo.AOAC_fibre_g, selectedFoodInfo.Sodium_mg, selectedFoodInfo.Potassium_mg, selectedFoodInfo.Calcium_mg, selectedFoodInfo.Magnesium_mg, selectedFoodInfo.Phosphorus_mg, selectedFoodInfo.Iron_mg, selectedFoodInfo.Copper_mg, selectedFoodInfo.Zinc_mg, selectedFoodInfo.Chloride_mg, selectedFoodInfo.Manganese_mg, selectedFoodInfo.Selenium_microg, selectedFoodInfo.Iodine_microg, selectedFoodInfo.Retinol_microg, selectedFoodInfo.Carotene_microg, selectedFoodInfo.Retinol_Equivalent_microg, selectedFoodInfo.Vitamin_D_microg, selectedFoodInfo.Vitamin_E_mg, selectedFoodInfo.Vitamin_K1_microg, selectedFoodInfo.Thiamin_mg, selectedFoodInfo.Riboflavin_mg, selectedFoodInfo.Niacin_mg, selectedFoodInfo.TryptophanP60_mg, selectedFoodInfo.NiacinEquivalent_mg, selectedFoodInfo.Vitamin_B6_mg, selectedFoodInfo.Vitamin_B12_microg, selectedFoodInfo.Folate_microg, selectedFoodInfo.Pantothenate_mg, selectedFoodInfo.Biotin_microg, selectedFoodInfo.Minerals_mg, selectedFoodInfo.Vitamin_mg]
        
        while cd_selections.count < 7{
            cd_selections.append(1)
        }
        while cd_selections.count < 39 {
            cd_selections.append(0)
        }
        
        // Add in core data
        for i in 0...38 {
            NutrientTypeCoreDataHandler.saveObject(type: cd_nutrientTypes[i], select: cd_selections[i], unit: cd_units[i], amount: cd_nutrientAmount[i])
        }
        print("GJ: saved default settings")
    }
    
    //MARK: get amount for display in the summary
    func getSummaryAmount(type: String, date: String, summary: Summary) -> Double{
        var amount:Double
        
        switch type {
            case "Water": amount = summary.water
            case "Fat": amount = summary.fat
            case "Protein": amount = summary.protein
            case "Carbohydrate": amount = summary.carbohydrate
            case "Sugar": amount = summary.sugar
            case "NSP": amount = summary.nsp
            case "Energy": amount = summary.energy
            case "AOAC Fibre": amount = summary.aoac_fibre
            case "Sodium": amount = summary.sodium
            case "Potassium": amount = summary.potassium
            case "Calcium": amount = summary.calcium
            case "Magnesium": amount = summary.magnesium
            case "Phosphorus": amount = summary.phosphorus
            case "Iron": amount = summary.iron
            case "Copper": amount = summary.copper
            case "Zinc": amount = summary.zinc
            case "Chloride": amount = summary.chloride
            case "Manganese": amount = summary.manganese
            case "Selenium":  amount = summary.selenium
            case "Iodine":  amount = summary.iodine
            case "Retinol": amount = summary.retinol
            case "Carotene": amount = summary.carotene
            case "Retinol Equivalent": amount = summary.retinol_equivalent
            case "Vitamin D": amount = summary.vitamin_d
            case "Vitamin E": amount = summary.vitamin_e
            case "Vitamin K1": amount = summary.vitamin_k1
            case "Thiamin": amount = summary.thiamin
            case "Riboflavin": amount = summary.riboflavin
            case "Niacin": amount = summary.niacin
            case "Tryptophan_p60": amount = summary.tryptophan_p60
            case "Niacin_equivalent": amount = summary.niacin_equivalent
            case "Vitamin B6": amount = summary.vitamin_b6
            case "Vitamin B12": amount = summary.vitamin_b12
            case "Folate": amount = summary.folate
            case "Pantothenate": amount = summary.pantothenate
            case "Biotin": amount = summary.biotin
            case "Vitamin C": amount = summary.vitamin_c
            default:
                amount = -1
                print("GJ: unknown nutrient type \(type) NutrientSelectionSetting")
        }
            return amount
    }
    
    func getNutrientAmount(selectedFoodInfo: FoodInfo, type: String) -> Double{
        let amount: Double
        switch type {
            case "Water": amount =  selectedFoodInfo.Water_g
            case "Fat": amount =  selectedFoodInfo.Fat_g
            case "Protein": amount =  selectedFoodInfo.Protein_g
            case "Carbohydrate": amount =  selectedFoodInfo.Carbohydrate_g
            case "Sugar": amount = selectedFoodInfo.Sugar_g
            case "NSP": amount =  selectedFoodInfo.NSP_g
            case "Energy": amount =  selectedFoodInfo.Energy_kcal
            case "AOAC Fibre": amount =  selectedFoodInfo.AOAC_fibre_g
            case "Sodium": amount =  selectedFoodInfo.Sodium_mg
            case "Potassium": amount =  selectedFoodInfo.Potassium_mg
            case "Calcium": amount =  selectedFoodInfo.Calcium_mg
            case "Magnesium": amount =  selectedFoodInfo.Magnesium_mg
            case "Phosphorus": amount =  selectedFoodInfo.Phosphorus_mg
            case "Iron": amount =  selectedFoodInfo.Iron_mg
            case "Copper": amount =  selectedFoodInfo.Copper_mg
            case "Zinc": amount =  selectedFoodInfo.Zinc_mg
            case "Chloride": amount =  selectedFoodInfo.Chloride_mg
            case "Manganese": amount =  selectedFoodInfo.Manganese_mg
            case "Selenium":  amount =  selectedFoodInfo.Selenium_microg
            case "Iodine":  amount =  selectedFoodInfo.Iodine_microg
            case "Retinol": amount =  selectedFoodInfo.Retinol_microg
            case "Carotene": amount =  selectedFoodInfo.Carotene_microg
            case "Retinol Equivalent": amount =  selectedFoodInfo.Retinol_Equivalent_microg
            case "Vitamin D": amount =  selectedFoodInfo.Vitamin_D_microg
            case "Vitamin E": amount =  selectedFoodInfo.Vitamin_E_mg
            case "Vitamin K1": amount =  selectedFoodInfo.Vitamin_K1_microg
            case "Thiamin": amount =  selectedFoodInfo.Thiamin_mg
            case "Riboflavin": amount =  selectedFoodInfo.Riboflavin_mg
            case "Niacin": amount =  selectedFoodInfo.Niacin_mg
            case "Tryptophan P60": amount =  selectedFoodInfo.TryptophanP60_mg
            case "Niacin Equivalent": amount =  selectedFoodInfo.NiacinEquivalent_mg
            case "Vitamin B6": amount =  selectedFoodInfo.Vitamin_B6_mg
            case "Vitamin B12": amount =  selectedFoodInfo.Vitamin_B12_microg
            case "Folate": amount =  selectedFoodInfo.Folate_microg
            case "Pantothenate": amount =  selectedFoodInfo.Pantothenate_mg
            case "Biotin": amount =  selectedFoodInfo.Biotin_microg
            case "Vitamin C": amount =  selectedFoodInfo.Vitamin_C_mg
            case "Mineral(total)": amount = selectedFoodInfo.Minerals_mg
            case "Vitamin(total)": amount = selectedFoodInfo.Vitamin_C_mg
            default:
                amount = -1
                print("GJ: something goes wrong when getting food information nutrient amount - NutrientSelectionSetting ")
        }
        return amount
    }
}
