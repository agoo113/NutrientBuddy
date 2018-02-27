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

    //MARK: IBoutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupContainerView: UIView!
    @IBOutlet weak var progressGroup: MKRingProgressGroupView!
    @IBOutlet weak var waterBar: HomeWaterBarView!
    
    //MARK: global variables
    var selectedFoodInfo = FoodInfo()
    var nutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
    var display_nutrient: [foodInformation] = []
    let date = NutrientDiary().getDate()
    //let date = "26/02/2018"
    
    var energyGoal = 8700.0 // function to set
    var waterGoal = 1000.0 // function to set
    
    var waterPercentage = 0.0
    //ring graph button
    var buttons: [MKRingProgressGroupButton] = []
    var selectedIndex = 0
    var proteinPercentage = 0.0
    var fatPercentage = 0.0
    var carboPercentage = 0.0
    var energyPercentage = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GJ: today's date is \(date)")
        
        //MARK: ring graphs
        let containerView = UIView(frame: navigationController!.navigationBar.bounds)
        navigationController!.navigationBar.addSubview(containerView)
        let w = (containerView.bounds.width - 16) / CGFloat(7)
        let h = containerView.bounds.height
        let button = MKRingProgressGroupButton(frame: CGRect(x: CGFloat(1) * w, y: 0, width: w, height: h))
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
        //MARK: nutrient to view
        //default if not set
        if nutrientToView.count != 38 {
            NutrientTypeCoreDataHandler.clearnDelete()
            NutrientSelectionSetting().setSelectionDefault(selectedFoodInfo: selectedFoodInfo)
            nutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
        }
        
        //load summary
        let summary = loadSummary()
        display_nutrient = loadFoodNutrition(nutrientToView: nutrientToView, summary: summary)
        getSummaryPrecentage()
        waterBar.drawProgressLayer(percentage: waterPercentage)
        //reload table
        tableView.reloadData()
        
    }

    private func loadSummary() -> Summary{
        let summary = NutrientDiary().updateNutrientsSummaryOfTheDay(date: date)
        if summary.date != nil{
            waterPercentage = (summary.water)/waterGoal
            //MARK: ring graphs
            let totalOfThree = summary.fat + summary.carbohydrate + proteinPercentage
            proteinPercentage = (summary.protein)/totalOfThree
            fatPercentage = (summary.fat)/totalOfThree
            carboPercentage = (summary.carbohydrate)/totalOfThree
            energyPercentage = (summary.energy)/(energyGoal)
            print("GJ: cunsumed water \(waterPercentage) g, protein \(proteinPercentage), fat \(fatPercentage), carbo \(energyPercentage)")
        }
        else{
            waterPercentage = 0
            //MARK: ring graphs
            proteinPercentage = 0
            fatPercentage = 0
            carboPercentage = 0
            energyPercentage = 0
        }
        
        return summary
    }
    
    //MARK: get nutrient information
    private func loadFoodNutrition(nutrientToView: [NutrientToView], summary: Summary) -> [foodInformation]{
        var displayNutrient: [foodInformation] = []
        var nutrientToAppend: foodInformation
        
        var summaryExist = true
        if summary.date != nil{
            summaryExist = false
        }
        
        for singleNutrient in nutrientToView {
            if singleNutrient.select == 1 {
                if summaryExist {
                    let amount = NutrientSelectionSetting().getSummaryAmount(type: singleNutrient.type!, date: date, summary:summary)
                    nutrientToAppend = foodInformation(nutrientType: singleNutrient.type!, amount: amount, unit: "(g)")!
                }
                else{
                    nutrientToAppend = foodInformation(nutrientType: singleNutrient.type!, amount: 0, unit: "(g)")!
                }
                displayNutrient.append(nutrientToAppend)
            }
        }
        return displayNutrient
    }
   
    
    //MARK: ring graphs
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
    @IBAction func getSummaryPrecentage(_ sender: AnyObject? = nil) {
        for button in buttons {
            button.contentView.ring1.progress = energyPercentage
            button.contentView.ring2.progress = fatPercentage
            button.contentView.ring3.progress = proteinPercentage
            button.contentView.ring4.progress = carboPercentage
        }
        updateMainGroupProgress()
    }
    
    //MARK: table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display_nutrient.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsDiary", for: indexPath) as! HomeTableViewCell
        let nutrientToDisplay = display_nutrient[indexPath.row]
        cell.nutrientTypeLabel.text = nutrientToDisplay.nutrientType
        var amountString = String(format: "%.3f", nutrientToDisplay.amount)
        amountString.append(nutrientToDisplay.unit)
        cell.nutrientAmountLabel.text = amountString
        //cell.contentView.setNeedsLayout()
        return cell
    }
}

