//
//  SettingViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 26/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import SafariServices

class SettingViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let links = ["https://www.healthline.com/nutrition/how-many-calories-per-day","https://www.choosemyplate.gov"]
    let help = ["Energy Setting Guide", "Ratio Setting Guide"]
    let goals = PersonalSettingCoreDataHandler.fetchObject()
    let attribute: [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.foregroundColor: UIColor.blue,
        NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue ]
    
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
        
        //Non of the goal can be zero
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
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return help.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
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
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientSetting")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalGuide")
        //cell?.textLabel?.textColor = UIColor.blue
        let attributeString = NSMutableAttributedString(string: help[indexPath.row], attributes: attribute)
        cell?.textLabel?.attributedText = attributeString
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let link = links[indexPath.row]
            let url = URL(string: link)
            let svc = SFSafariViewController(url: url!)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Nutrient Goal"
        }
        if section == 1 {
            return "Select Nutrient"
        }
        else {
            return "Help"
        }
    }
}
