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
        
        waterGoalTextField.delegate = self
        energyGoalTextField.delegate = self
        carboGoalTextField.delegate = self
        proteinGoalTextField.delegate = self
        fatGoalTextField.delegate = self

    }

    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            switch textField {
            case self.waterGoalTextField:
                self.water = Double(textField.text!)!
            case self.energyGoalTextField:
                self.energy = Double(textField.text!)!
            case self.carboGoalTextField:
                self.carbo = Double(textField.text!)!
            case self.fatGoalTextField:
                self.fat = Double(textField.text!)!
            case self.proteinGoalTextField:
                self.protein = Double(textField.text!)!
            default:
                goalAltered = false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.waterGoalTextField:
            self.water = Double(textField.text!)!
        case self.energyGoalTextField:
            self.energy = Double(textField.text!)!
        case self.carboGoalTextField:
            self.carbo = Double(textField.text!)!
        case self.fatGoalTextField:
            self.fat = Double(textField.text!)!
        case self.proteinGoalTextField:
            self.protein = Double(textField.text!)!
        default:
            goalAltered = false
        }
        return true
    }
}
