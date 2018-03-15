//
//  SettingViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 26/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let goals = PersonalSettingCoreDataHandler.fetchObject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func saveButtonItemTapped(_ sender: UIBarButtonItem) {
        let goal = goals?.first
        
        let index = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: index) as! GoalSettingTableViewCell
        let water: Double
        let energy: Double
        let fat: Double
        let carbo: Double
        let protein: Double
        let vitaminC: Double
        let sugar: Double
        
        if cell.water != 0 {
           water  = cell.water
        } else {
            water = (goal?.water_goal)!
        }
        if cell.energy != 0 {
            energy  = cell.energy
        } else {
            energy = (goal?.energy_goal)!
        }
        if cell.protein != 0 {
            protein  = cell.protein
        } else {
            protein = (goal?.protein_goal)!
        }
        if cell.fat != 0 {
            fat  = cell.fat
        } else {
            fat = (goal?.fat_goal)!
        }
        if cell.carbo != 0 {
            carbo  = cell.carbo
        } else {
            carbo = (goal?.carbo_goal)!
        }
        if cell.vitaminC != 0 {
            vitaminC = cell.vitaminC
        } else {
            vitaminC = (goal?.vitamin_c_goal)!
        }
        if cell.sugar != 0 {
            sugar = cell.sugar
        } else {
            sugar = (goal?.sugar_goal)!
        }
        PersonalSettingCoreDataHandler.cleanDelete()
        PersonalSettingCoreDataHandler.saveObject(carboGoal: carbo, energyGoal: energy, fatGoal: fat, proteinGoal: protein, vitaminCGoal: vitaminC, sugarGoal: sugar, waterGoal: water)
        
        if debugPersonalSetting {
            let goals = PersonalSettingCoreDataHandler.fetchObject()
            for each in goals! {
                print(each)
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientSetting")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalSetting") as! GoalSettingTableViewCell
        let goal = goals?.first
        cell.waterGoalTextField.placeholder = String(format: "%.0f", (goal?.water_goal)!)
        cell.energyGoalTextField.placeholder = String(format: "%.0f", (goal?.energy_goal)!)
        cell.carboGoalTextField.placeholder = String(format: "%.0f", (goal?.carbo_goal)!)
        cell.fatGoalTextField.placeholder = String(format: "%.0f", (goal?.fat_goal)!)
        cell.proteinGoalTextField.placeholder = String(format: "%.0f", (goal?.protein_goal)!)
        cell.vitaminCGoalTextField.placeholder = String(format: "%.0f", (goal?.vitamin_c_goal)!)
        cell.sugarLimitTextField.placeholder = String(format: "%.0f", (goal?.sugar_goal)!)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
