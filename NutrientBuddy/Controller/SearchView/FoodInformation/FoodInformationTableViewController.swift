//
//  FoodInformationTableViewController.swift
//  DemoSearch
//
//  Created by Gemma Jing on 22/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit

class FoodInformationTableViewController: UITableViewController {
    
    var selectedFoodInfo = FoodInfo() // loaded from last page
    // load the nutrient selection core data
    var nutrientToView: [NutrientToView] = []
    //display nutrient on this page
    var display_nutrient: [foodInformation] = []
    var amount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: edit button to select nutrients
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addView"), style: .plain, target: self, action: #selector(addFoodButtonItemTapped))
        
        //MARK: add default if there is nothing in the nutrient selection core data
        nutrientToView = NutrientTypeCoreDataHandler.fetchObject()!
        loadFoodNutrition(nutrientToView: nutrientToView)
    }
   
    // MARK: get nutrient information
    private func loadFoodNutrition(nutrientToView: [NutrientToView]){
        for singleNutrient in nutrientToView {
            if singleNutrient.select == 1 {
                let selectedNutrientAmount = NutrientSelectionSetting().getNutrientAmount(selectedFoodInfo: selectedFoodInfo, type: singleNutrient.type!)
                let nutrientToView = foodInformation(nutrientType: singleNutrient.type!, amount: selectedNutrientAmount, unit: singleNutrient.unit!)
                    display_nutrient.append(nutrientToView!)
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (display_nutrient.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicInfo", for: indexPath) as! FoodInformationTableViewCell
            let nameArray = getFoodNameAndImage()
            cell.foodNameLabel.text = nameArray[0]
            if (UIImage(named: nameArray[0]) != nil) {
                cell.foodImage.image = UIImage(named: nameArray[0])
            }
            else {
                cell.foodImage.image = UIImage(named: "Placeholder")
            }
            //clear foodDescriptionLabel.text before appending
            cell.foodDescriptionLabel.text = "Description: "
            if nameArray.count == 2 {
                cell.foodDescriptionLabel.text?.append(nameArray[1])
                cell.foodDescriptionLabel.lineBreakMode = .byWordWrapping
                cell.foodDescriptionLabel.numberOfLines = 0
            }
            //cell.foodItem = selectedFoodInfo
            if amount != 0 {
                cell.amountSlider.setValue(Float(amount), animated: true)
            }
            return cell
        }
        
        // Nutrients table cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientInfo", for: indexPath) as! FoodInformationSecondTableViewCell
        let nutrientToView = display_nutrient[indexPath.row - 1]
        cell.nutrientTypeLabel.text = nutrientToView.nutrientType
        var amountString = String(format: "%.3f", nutrientToView.amount)
        amountString.append(nutrientToView.unit)
        cell.amountLabel.text = amountString
        cell.contentView.setNeedsLayout()
        return cell
    }
    
    //MARK: prepare for the first type of cell
    func getFoodNameAndImage() -> [String] {
        let refindedName = selectedFoodInfo.Food_Name.replacingOccurrences(of: "_", with: " ")
        let substringArray = refindedName.split(separator: ",", maxSplits: 1, omittingEmptySubsequences: true)
        var nameArray = [String]()
        nameArray.append(String(substringArray[0]))
        if(substringArray.count == 2){
            nameArray.append(String(substringArray[1]))
        }
        return nameArray
    }
    
    // open the nutrientToView selection view controller
    @objc func addFoodButtonItemTapped(_ sender: UIBarButtonItem!){
        let alert = UIAlertController(title: "Nutrient Buddy", message: "Do you want to save this item?", preferredStyle: UIAlertControllerStyle.alert)
        let actionOkay = UIAlertAction(title: "OK", style: .default) { (_) in
            let indexPath = IndexPath(row: 0, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath) as! FoodInformationTableViewCell
            self.amount = Double(cell.amountSlider.value)
            if self.amount == 0{
                let alertSecond = UIAlertController(title: "Nutrient Buddy", message: "You did not specify food amount! Please cancel and select amount!", preferredStyle: UIAlertControllerStyle.alert)
                self.present(alertSecond, animated: true, completion: nil)
            }
            else{
                print("GJ: saved on \(NutrientDiary().getDate()), amount = \(self.amount) grams of \(self.selectedFoodInfo.Food_Name)")
                NutrientDiary().saveDiaryToCoredata(savedFood: self.selectedFoodInfo, amount: self.amount)
                self.goToHome()
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in
            print("GJ: canceled adding food item")
        }
        alert.addAction(actionOkay)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
        
    }
    func goToHome(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logFoodViewController = storyBoard.instantiateViewController(withIdentifier: "myMeals") as! LogFoodViewController
        self.navigationController?.pushViewController(logFoodViewController, animated: true)
    }

}
