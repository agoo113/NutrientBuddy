//
//  GoalSettingTableViewCell.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 28/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class GoalSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var waterGoalTextField: UITextField!
    @IBOutlet weak var energyGoalTextField: UITextField!
    @IBOutlet weak var carboGoalTextField: UITextField!
    @IBOutlet weak var proteinGoalTextField: UITextField!
    @IBOutlet weak var fatGoalTextField: UITextField!

    let goals = PersonalSettingCoreDataHandler.fetchObject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        fatGoalTextField.text = String(format: "%f.0", (goal?.fat_goal)!)
        proteinGoalTextField.text = String(format: "%.0f", (goal?.protein_goal)!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
