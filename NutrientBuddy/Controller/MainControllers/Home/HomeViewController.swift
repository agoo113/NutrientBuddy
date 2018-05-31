//
//  ViewController.swift
//  DemoSearch
//
//  Created by Gemma Jing on 05/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit

func delay(_ delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tappedRings = false
    //MARK: IBoutlet with the view
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupContainerView: UIView!
    @IBOutlet weak var progressGroup: MKRingProgressGroupView!
    
    var buttons: [MKRingProgressGroupButton] = []
    var selectedIndex = 0
    
    //MARK: global variables
    var nutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
    var display_nutrient: [foodInformation] = []
    let date = NutrientDiary().getDate()
    var personalGoals = PersonalSettingCoreDataHandler.fetchObject()!
    var ringPercentages = percentageConsumedForRings()
    var barPercentages = percentageConsumedForBars()
    
    override func viewDidAppear(_ animated: Bool) {
        if debugHomeView {
            print("GJ: today's date is \(date), from view did appear - HomeViewController")
        }
        
        //load personal goal default
        if personalGoals.count == 0 {
            PersonalSettingCoreDataHandler.saveObject(carboGoal: 4, energyGoal: 2000, fatGoal: 2, proteinGoal: 4, vitaminCGoal: 40, sugarGoal: 6, waterGoal: 8)
        }
        personalGoals = PersonalSettingCoreDataHandler.fetchObject()!
        let goal = personalGoals[0]
    
        //load summary
        let summaryAndPercentages = HomeViewFunctions().loadSummaryAndPercentages(waterGoal: goal.water_goal, energyGoal: goal.energy_goal, date: date, carboGoal: goal.carbo_goal, proteinGoal: goal.protein_goal, vitaminCGoal: goal.vitamin_c_goal, fatGoal: goal.fat_goal, sugarGoal: goal.sugar_goal)
        let summary = summaryAndPercentages.summary
        
        ringPercentages = summaryAndPercentages.ringsPercentage
        barPercentages = summaryAndPercentages.barsPercentage
        
        alertIfNeeded(ringPercentages: ringPercentages, barPercentages: barPercentages)
        //display other nutrient information
        if debugNutrientSetting {
            print("GJ: there are \(nutrientToView.count) items")
            for each in nutrientToView {
                print(each)
            }
        }
        nutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
        if debugNutrientSetting {
            print("GJ: there are \(nutrientToView.count) items")
            for each in nutrientToView {
                print(each)
            }
        }
        nutrientToView = HomeViewFunctions().getNutrientToView(nutrientToView: nutrientToView)
        display_nutrient = HomeViewFunctions().loadFoodNutrition(nutrientToView: nutrientToView, summary: summary, date: date)
        
        //delete extra summaries
        HomeViewFunctions().deletePreviousNutrientSummaryIfExist(date: date)
        
        //ring graph
        randeringRingView()
        getSummaryPrecentageForRings()
        
        //reload table
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.reloadData()
    }

    //MARK: display alert for over consumption and goal achievement
    func alertIfNeeded (ringPercentages: percentageConsumedForRings, barPercentages: percentageConsumedForBars) {
        if (ringPercentages.energyPercentage > 1 || ringPercentages.carboPercentage > 1 || ringPercentages.proteinPercentage > 1 || ringPercentages.fatPercentage > 1 || barPercentages.waterGlassesConsumed > barPercentages.waterGlassesGoal || barPercentages.sugarPercentage > barPercentages.sugarSpoonGoal) {
            createAlert(message: "Some goals/limits has been reached, please refer to Nutrition section for detials")
        }
    }
    //MARK: ring graphs
    func randeringRingView() {
        let containerView = UIView(frame: navigationController!.navigationBar.bounds)
        
        groupContainerView.addSubview(containerView)
        let w = (containerView.bounds.width - 16) / CGFloat(7)
        let h = containerView.bounds.height
        let button = MKRingProgressGroupButton(frame: CGRect(x: CGFloat(0) * w, y: 0, width: w, height: h))
        button.contentView.ringWidth = 4.5
        button.contentView.ringSpacing = 1
        button.contentView.ring1StartColor = progressGroup.ring1StartColor
        button.contentView.ring1EndColor = progressGroup.ring1EndColor
        button.contentView.ring2StartColor = progressGroup.ring2StartColor
        button.contentView.ring2EndColor = progressGroup.ring2EndColor
        button.contentView.ring3StartColor = progressGroup.ring3StartColor
        button.contentView.ring3EndColor = progressGroup.ring3EndColor
        button.contentView.ring4StartColor = progressGroup.ring4StartColor
        button.contentView.ring4EndColor = progressGroup.ring4EndColor
        containerView.addSubview(button)
        buttons.append(button)
        button.isHidden = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttons[0].isSelected = true
        
        delay(0.5) {
            self.updateMainGroupProgress()
        }
    }
    @objc func buttonTapped(_ sender: MKRingProgressGroupButton) {
        let newIndex = buttons.index(of: sender) ?? 0
        let dx = (newIndex > selectedIndex) ? -self.view.frame.width : self.view.frame.width
        
        buttons[selectedIndex].isSelected = false
        sender.isSelected = true
        selectedIndex = newIndex
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            self.groupContainerView.transform = CGAffineTransform(translationX: dx, y: 0)
        }) { (_) -> Void in
            self.groupContainerView.transform = CGAffineTransform(translationX: -dx, y: 0)
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.0)
            self.progressGroup.ring1.progress = 0.0
            self.progressGroup.ring2.progress = 0.0
            self.progressGroup.ring3.progress = 0.0
            self.progressGroup.ring4.progress = 0.0
            CATransaction.commit()
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
                self.groupContainerView.transform = CGAffineTransform.identity
            }, completion: { (_) -> Void in
                self.updateMainGroupProgress()
            })
        }
    }
    
    private func updateMainGroupProgress() {
        let selectedGroup = buttons[selectedIndex]
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        self.progressGroup.ring1.progress = selectedGroup.contentView.ring1.progress
        self.progressGroup.ring2.progress = selectedGroup.contentView.ring2.progress
        self.progressGroup.ring3.progress = selectedGroup.contentView.ring3.progress
        self.progressGroup.ring4.progress = selectedGroup.contentView.ring4.progress
        CATransaction.commit()
    }
    
    //get summart for protain, fat, carbohydrate and energy
    func getSummaryPrecentageForRings(_ sender: AnyObject? = nil) {
        for button in buttons {
            button.contentView.ring1.progress = ringPercentages.energyPercentage
            button.contentView.ring2.progress = ringPercentages.carboPercentage
            button.contentView.ring3.progress = ringPercentages.proteinPercentage
            button.contentView.ring4.progress = ringPercentages.fatPercentage
        }
        updateMainGroupProgress()
    }
    
    //MARK: table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }
        else {
            return display_nutrient.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! HomeProgressBarTableViewCell
            cell.nutrientLabel.textAlignment = .right
            
            if indexPath.row == 0 {
                let barColor = UIColor(hue: 0.5417, saturation: 0.37, brightness: 0.98, alpha: 1.0).cgColor
                let fillColor = UIColor(hue: 0.5417, saturation: 1, brightness: 0.98, alpha: 1.0).cgColor
                let percentage = barPercentages.waterGlassesConsumed/barPercentages.waterGlassesGoal
                cell.drawProgressLayer(percentage: percentage, fillColor: fillColor, barColor: barColor)
                cell.viewProg.bringSubview(toFront: cell.nutrientLabel)
                cell.nutrientView.image = UIImage(named: "waterBarIcon")
                
                cell.nutrientLabel.text = String(format: "%.0f", barPercentages.waterGlassesConsumed) + "/" + String(format: "%.0f", barPercentages.waterGlassesGoal) + " Glass(es)"
            }
            if indexPath.row == 1 {
                let barColor = UIColor(hue: 0.1306, saturation: 0.36, brightness: 0.99, alpha: 1.0).cgColor
                let fillColor = UIColor(hue: 0.1306, saturation: 1, brightness: 0.99, alpha: 1.0).cgColor
                cell.drawProgressLayer(percentage: barPercentages.vitaminCPercentage, fillColor: fillColor, barColor: barColor)
                cell.viewProg.bringSubview(toFront: cell.nutrientLabel)
                cell.nutrientView.image = UIImage(named: "vitaminCView")
                cell.nutrientLabel.text = String(format: "%.0f", barPercentages.vitaminCPercentage * 100) + "%"
            }
            if indexPath.row == 2 {
                let fillColor = UIColor.red.cgColor
                let barColor = UIColor(hue: 0.05, saturation: 0.47, brightness: 0.95, alpha: 1.0).cgColor
                let percentage = barPercentages.sugarPercentage/barPercentages.sugarSpoonGoal
                cell.drawProgressLayer(percentage: percentage, fillColor: fillColor, barColor: barColor)
                cell.viewProg.bringSubview(toFront: cell.nutrientLabel)
                cell.nutrientView.image = UIImage(named: "sugarView")
                cell.nutrientLabel.text = String(format: "%.0f", barPercentages.sugarPercentage) + "/" + String(format: "%.0f", barPercentages.sugarSpoonGoal) + "Teaspoon(s)"
            }
             return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsSummaryDetails", for: indexPath) as! NutrientSummayDetailTableViewCell
            cell.adviceLabel.textColor = UIColor.red
            cell.adviceLabel.isHidden = true
            cell.adviceLabel.frame = CGRect(x: 0, y: 0, width: 345, height: 0)
            cell.nutrientAmountLabel.textAlignment = .right
            
            let nutrientToDisplay = display_nutrient[indexPath.row]
            cell.nutrientTypeLabel.text = nutrientToDisplay.nutrientType
            
            var amountString: String = String(format: "%.0f", nutrientToDisplay.amount)
            
            switch nutrientToDisplay.nutrientType {
                case "Energy": cell.nutrientTypeLabel.textColor = UIColor(red: 209/254, green: 5/255, blue: 17/255, alpha: 1)
                cell.nutrientAmountLabel.textColor = UIColor(red: 209/255, green: 5/255, blue: 17/255, alpha: 1)
                cell.nutrientAmountLabel.text = amountString + "/" + String(format: "%.0f", ringPercentages.energyGoal) + "(kcal)"
                if ringPercentages.energyPercentage > 1 {
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "You have reached the energy goal, please go for some cardio workouts!"
                }
                case "Carbohydrate": cell.nutrientTypeLabel.textColor = UIColor.orange
                cell.nutrientAmountLabel.textColor = UIColor.orange
                cell.nutrientAmountLabel.text = amountString + "/" + String(format: "%.0f", ringPercentages.totalCarboGoal) + "(g)"
                if ringPercentages.carboPercentage > 1 {
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "You have reached the carbohydrate limit, you can do some cardio or increase protein consumption."
                }

                case "Protein": cell.nutrientTypeLabel.textColor = UIColor.blue
                cell.nutrientAmountLabel.textColor = UIColor.blue
                cell.nutrientAmountLabel.text = amountString + "/" +  String(format: "%.0f", ringPercentages.totalProteinGoal) + "(g)"
                if ringPercentages.proteinPercentage > 1 {
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "You have reached the protein limit, well done!"
                }

                case "Fat": cell.nutrientTypeLabel.textColor = UIColor.purple
                cell.nutrientAmountLabel.textColor = UIColor.purple
                cell.nutrientAmountLabel.text = amountString + "/" + String(format: "%.0f", ringPercentages.totalFatGoal) + "(g)"
                if ringPercentages.fatPercentage > 1 {
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "You have reached the fat limit, you can do some cardio or increase protein consumption."
                }
                
                case "Water": cell.nutrientTypeLabel.textColor = UIColor.black
                    cell.nutrientAmountLabel.text = amountString + "(ml)"
                if barPercentages.waterGlassesConsumed >=  barPercentages.waterGlassesGoal {
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "Well done, you have had enough water today!"
                }
                case "Sugar":
                cell.nutrientTypeLabel.textColor = UIColor.black
                cell.nutrientAmountLabel.textColor = UIColor.black
                cell.nutrientAmountLabel.text = amountString + ("(g)")
                if barPercentages.sugarPercentage > barPercentages.waterGlassesGoal {
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "You have reached the sugar limit, you have to be careful with carbohydate consumption today."
                }
                case "Vitamin C":
                    cell.nutrientTypeLabel.textColor = UIColor.black
                    cell.nutrientAmountLabel.textColor = UIColor.black
                    amountString = String(format: "%.0f", nutrientToDisplay.amount*1000)
                    cell.nutrientAmountLabel.text = amountString + ("(mg)")
                if barPercentages.vitaminCPercentage > 1{
                    cell.adviceLabel.isHidden = false
                    cell.adviceLabel.numberOfLines = 0
                    cell.adviceLabel.text = "You have reached the vitamin C goal, well done!"
                }

                default:
                    // measured in mg
                    if nutrientToDisplay.amount < 0.000001{
                        amountString = String(format: "%.0f", nutrientToDisplay.amount*1000000)
                        amountString.append("(μg)")
                    }
                    else if nutrientToDisplay.amount < 1 {
                        amountString = String(format: "%.0f", nutrientToDisplay.amount*1000)
                        amountString.append("(mg)")
                    }
                    else {
                        amountString = String(format: "%.0f", nutrientToDisplay.amount)
                        amountString.append("(g)")
                    }
                    cell.nutrientTypeLabel.textColor = UIColor.black
                    cell.nutrientAmountLabel.textColor = UIColor.black
                    cell.nutrientAmountLabel.text = amountString

            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Nutrition"
        }
        return "Other Tracked Nutrients"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let nutrientToDisplay = display_nutrient[indexPath.row]
            let rowHeightWithAdvice = CGFloat(150)
            let rowHeightDefault = CGFloat(65)
            
            switch nutrientToDisplay.nutrientType {
            case "Energy":
                if ringPercentages.energyPercentage > 1 {
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
            case "Carbohydrate":
                if ringPercentages.carboPercentage > 1 {
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
            case "Protein":
                if ringPercentages.proteinPercentage > 1 {
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
            case "Fat":
                if ringPercentages.fatPercentage > 1 {
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
            case "Water":
                if barPercentages.waterGlassesConsumed >=  barPercentages.waterGlassesGoal {
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
            case "Sugar":
                if barPercentages.sugarPercentage > barPercentages.waterGlassesGoal {
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
            case "Vitamin C":
                if barPercentages.vitaminCPercentage > 1{
                    return rowHeightWithAdvice
                }
                else {
                    return rowHeightDefault
                }
                
            default:
                return rowHeightDefault
            }
        }
        let nutrientBarHeight = CGFloat(90)
        return nutrientBarHeight
    }
    
    func createAlert(message: String) {
        let alert = UIAlertController(title: "Nutrient Buddy", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

