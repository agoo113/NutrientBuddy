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
    var nutrientSelection: [Nutrient] = []
    //display nutrient on this page
    var display_nutrient: [foodInformation] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nutrientSelection = NutrientTypeCoreDataHandler.fetchObject()!
        if nutrientSelection.count != 38 {
        NutrientSelectionSetting().setSelectionDefault(selectedFoodInfo: selectedFoodInfo)
            nutrientSelection = NutrientTypeCoreDataHandler.fetchObject()!
        }
        
        display_nutrient.removeAll()
        loadFoodNutrition(nutrient: nutrientSelection)
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: edit button to select nutrients
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonItemTapped))
        
        //MARK: add default if there is nothing in the nutrient selection core data
        nutrientSelection = NutrientTypeCoreDataHandler.fetchObject()!
        if nutrientSelection.count != 38 {
            NutrientTypeCoreDataHandler.clearnDelete()
            NutrientSelectionSetting().setSelectionDefault(selectedFoodInfo: selectedFoodInfo)
            nutrientSelection = NutrientTypeCoreDataHandler.fetchObject()!
        }
        loadFoodNutrition(nutrient: nutrientSelection)
    }
    
   
    // MARK: get nutrient information
    private func loadFoodNutrition(nutrient: [Nutrient]){
        // id = 1 for nutrient of choice to display
        for singleNutrient in nutrientSelection {
            if singleNutrient.select == 1 {
                let nutrient = foodInformation(nutrientType: singleNutrient.type!, amount: singleNutrient.amount, unit: singleNutrient.unit!)
                    display_nutrient.append(nutrient!)
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
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicInfo", for: indexPath) as! FoodInformationTableViewCell
            let nameArray = getFoodNameAndImage()
            cell.foodNameLabel.text = nameArray[0]
            cell.foodImage.image = UIImage(named: nameArray[0])
            //clear foodDescriptionLabel.text before appending
            cell.foodDescriptionLabel.text = "Description: "
            if nameArray.count == 2 {
                cell.foodDescriptionLabel.text?.append(nameArray[1])
                cell.foodDescriptionLabel.lineBreakMode = .byWordWrapping
                cell.foodDescriptionLabel.numberOfLines = 0
            }
            cell.foodItem = selectedFoodInfo
            return cell
        }
        
        // Nutrients table cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientInfo", for: indexPath) as! FoodInformationSecondTableViewCell
        let nutrient = display_nutrient[indexPath.row - 1]
        cell.nutrientTypeLabel.text = nutrient.nutrientType
        //print("displaying nutrient type: \(nutrient.nutrientType)")
        var amountString = String(format: "%.3f", nutrient.amount)
        amountString.append(nutrient.unit)
        cell.amountLabel.text = amountString
        cell.contentView.setNeedsLayout()
        return cell
    }
    
    // MARK: prepare for the first type of cell
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
    
    // open the nutrient selection view controller
    @objc func editButtonItemTapped(_ sender: UIBarButtonItem!){
        let NutrientSelectionViewController = storyboard?.instantiateViewController(withIdentifier: "nutrientSelection") as! NutrientTypeSelectionViewController
        present(NutrientSelectionViewController, animated: true, completion: nil)
    }

}
