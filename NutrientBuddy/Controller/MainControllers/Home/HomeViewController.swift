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
    //ring graph button
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carboLabel: UILabel!
    @IBOutlet weak var labelStack: UIStackView!
    @IBOutlet weak var nutrientNameLabelStack: UIStackView!
    
    var buttons: [MKRingProgressGroupButton] = []
    var selectedIndex = 0
    
    //MARK: global variables
    var nutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
    var display_nutrient: [foodInformation] = []
    let date = NutrientDiary().getDate()
    var personalGoals = PersonalSettingCoreDataHandler.fetchObject()!
    var ringPercentages = percentageConsumedForRings()
    var barPercentages = percentageConsumedForBars()
    
    //MARK: controls the display of labels
    @objc func tappedOnEnergy(_ sender: UITapGestureRecognizer){
        if tappedRings {
            labelStack.isHidden = true
            nutrientNameLabelStack.isHidden = true
            tappedRings = false
        }
        else{
            labelStack.isHidden = false
            nutrientNameLabelStack.isHidden = false
            tappedRings = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //ring view
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnEnergy))
        self.progressGroup.addGestureRecognizer(gesture)
        self.progressGroup.bringSubview(toFront: labelStack)
        self.progressGroup.bringSubview(toFront: nutrientNameLabelStack)
        
        if debugHomeView {
            print("GJ: today's date is \(date), from view did appear - HomeViewController")
        }
        //load personal goal
        if personalGoals.count == 0 {
            PersonalSettingCoreDataHandler.saveObject(carboGoal: 30, energyGoal: 8700, fatGoal: 20, proteinGoal: 50, vitaminCGoal: 40, sugarGoal: 25, waterGoal: 1200)
        }
        personalGoals = PersonalSettingCoreDataHandler.fetchObject()!
        let goal = personalGoals[0]
    
        //load summary
        let summaryAndPercentages = HomeViewFunctions().loadSummaryAndPercentages(waterGoal: goal.water_goal, energyGoal: goal.energy_goal, date: date, carboGoal: goal.carbo_goal, proteinGoal: goal.protein_goal, vitaminCGoal: goal.vitamin_c_goal, fatGoal: goal.fat_goal, sugarGoal: goal.sugar_goal)
        let summary = summaryAndPercentages.summary
        ringPercentages = summaryAndPercentages.ringsPercentage
        barPercentages = summaryAndPercentages.barsPercentage
        
        energyLabel.text = String(format: "%.2f", ringPercentages.energyPercentage*100) + "%"
        fatLabel.text = String(format: "%.2f", ringPercentages.fatPercentage*100) + "%"
        proteinLabel.text = String(format: "%.2f", ringPercentages.proteinPercentage*100) + "%"
        carboLabel.text = String(format: "%.2f", ringPercentages.carboPercentage*100) + "%"
        
        
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
        tableView.estimatedRowHeight = 120
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelStack.isHidden = true
        nutrientNameLabelStack.isHidden = true
        
        let goal = personalGoals[0]
        let summaryAndPercentages = HomeViewFunctions().loadSummaryAndPercentages(waterGoal: goal.water_goal, energyGoal: goal.energy_goal, date: date, carboGoal: goal.carbo_goal, proteinGoal: goal.protein_goal, vitaminCGoal: goal.vitamin_c_goal, fatGoal: goal.fat_goal, sugarGoal: goal.sugar_goal)
        let summary = summaryAndPercentages.summary
        display_nutrient = HomeViewFunctions().loadFoodNutrition(nutrientToView: nutrientToView, summary: summary, date: date)
        
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
            button.contentView.ring2.progress = ringPercentages.fatPercentage
            button.contentView.ring3.progress = ringPercentages.proteinPercentage
            button.contentView.ring4.progress = ringPercentages.carboPercentage
        }
        updateMainGroupProgress()
    }
    
    //MARK: table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else {
            return display_nutrient.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! HomeProgressBarTableViewCell
            if indexPath.row == 0 {
                let fillColor = UIColor(red: 0, green: 215, blue: 234, alpha: 1).cgColor
                let barColor = UIColor.blue.cgColor
                cell.drawProgressLayer(percentage: barPercentages.waterPercentage, fillColor: fillColor, barColor: barColor)
                cell.viewProg.bringSubview(toFront: cell.nutrientLabel)
                cell.nutrientView.image = UIImage(named: "waterBarIcon")
                cell.nutrientLabel.text = String(format: "%.2f", barPercentages.waterPercentage * 100) + "%"
            }
            if indexPath.row == 1 {
                let fillColor = UIColor(red: 247, green: 214, blue: 0, alpha: 1).cgColor
                let barColor = UIColor.orange.cgColor
                cell.drawProgressLayer(percentage: barPercentages.vitaminCPercentage, fillColor: fillColor, barColor: barColor)
                cell.viewProg.bringSubview(toFront: cell.nutrientLabel)
                cell.nutrientView.image = UIImage(named: "vitaminCView")
                cell.nutrientLabel.text = String(format: "%.2f", barPercentages.vitaminCPercentage * 100) + "%"
            }
            if indexPath.row == 2 {
                let fillColor = UIColor.red.cgColor
                let barColor = UIColor.magenta.cgColor
                cell.drawProgressLayer(percentage: barPercentages.sugarPercentage, fillColor: fillColor, barColor: barColor)
                cell.viewProg.bringSubview(toFront: cell.nutrientLabel)
                cell.nutrientView.image = UIImage(named: "sugarView")
                cell.nutrientLabel.text = String(format: "%.2f", barPercentages.sugarPercentage * 100) + "%"
            }
             return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsSummaryDetails", for: indexPath) as! NutrientSummayDetailTableViewCell
            
            let nutrientToDisplay = display_nutrient[indexPath.row]
            cell.nutrientTypeLabel.text = nutrientToDisplay.nutrientType
            var amountString = String(format: "%.3f", nutrientToDisplay.amount)
            amountString.append(nutrientToDisplay.unit)
            cell.nutrientAmountLabel.text = amountString
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Nutrient Diary Details"
        }
        return "Other Nurition View"
    }
    
}

