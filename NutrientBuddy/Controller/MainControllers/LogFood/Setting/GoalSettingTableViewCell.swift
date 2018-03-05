//
//  GoalSettingTableViewCell.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 28/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class GoalSettingTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var waterGoalTextField: UITextField!
    @IBOutlet weak var energyGoalTextField: UITextField!
    @IBOutlet weak var carboGoalTextField: UITextField!
    @IBOutlet weak var proteinGoalTextField: UITextField!
    @IBOutlet weak var fatGoalTextField: UITextField!

    var water: Double = 0.0
    var protein: Double = 0.0
    var fat: Double = 0.0
    var carbo: Double = 0.0
    var energy: Double = 0.0
    var goalAltered: Bool = true
    
    let goals = PersonalSettingCoreDataHandler.fetchObject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        waterGoalTextField.keyboardType = UIKeyboardType.numberPad
        energyGoalTextField.keyboardType = UIKeyboardType.numberPad
        carboGoalTextField.keyboardType = UIKeyboardType.numberPad
        proteinGoalTextField.keyboardType = UIKeyboardType.numberPad
        fatGoalTextField.keyboardType = UIKeyboardType.numberPad
        
        waterGoalTextField.delegate = self
        energyGoalTextField.delegate = self
        carboGoalTextField.delegate = self
        proteinGoalTextField.delegate = self
        fatGoalTextField.delegate = self
        
        // Initialization code
        if debugPersonalSetting {
            for each in goals! {
                print(each)
            }
            print("GJ: the size of the personal is \(String(format: "%.0f", (goals?.count)!)) -- SettingViewController")
        }
        let goal = goals?.first
        waterGoalTextField.text = String(format: "%.0f", (goal?.water_goal)!)
        energyGoalTextField.text = String(format: "%.0f", (goal?.energy_goal)!)
        carboGoalTextField.text = String(format: "%.0f", (goal?.carbo_goal)!)
        fatGoalTextField.text = String(format: "%.0f", (goal?.fat_goal)!)
        proteinGoalTextField.text = String(format: "%.0f", (goal?.protein_goal)!)

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case self.waterGoalTextField:
            water = Double(textField.text!)!
        case self.energyGoalTextField:
            energy = Double(textField.text!)!
        case self.carboGoalTextField:
            carbo = Double(textField.text!)!
        case self.fatGoalTextField:
            fat = Double(textField.text!)!
        case self.proteinGoalTextField:
            protein = Double(textField.text!)!
        default:
            goalAltered = false
        }
    }
}
