//
//  NutrientSummaryDetailViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 13/03/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class NutrientSummaryDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var display_nutrient: [foodInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display_nutrient.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsDiary", for: indexPath) as! HomeTableViewCell
        let nutrientToDisplay = display_nutrient[indexPath.row]
        
        switch nutrientToDisplay.nutrientType {
        case "Water":
            cell.nutrientTypeLabel.textColor = UIColor(red: 0, green: 215, blue: 234, alpha: 1)
            cell.nutrientAmountLabel.textColor = UIColor(red: 0, green: 215, blue: 234, alpha: 1)
        case "Fat":
            cell.nutrientTypeLabel.textColor = UIColor.purple
            cell.nutrientAmountLabel.textColor = UIColor.purple
        case "Protein":
            cell.nutrientTypeLabel.textColor = UIColor.blue
            cell.nutrientAmountLabel.textColor = UIColor.blue
        case "Energy":
            cell.nutrientTypeLabel.textColor = UIColor.red
            cell.nutrientAmountLabel.textColor = UIColor.red
        case "Carbohydrate":
            cell.nutrientTypeLabel.textColor = UIColor.yellow
            cell.nutrientAmountLabel.textColor = UIColor.yellow
        default:
            cell.nutrientTypeLabel.textColor = UIColor.white
            cell.nutrientAmountLabel.textColor = UIColor.white
        }
        cell.nutrientTypeLabel.text = nutrientToDisplay.nutrientType
        var amountString = String(format: "%.3f", nutrientToDisplay.amount)
        amountString.append(nutrientToDisplay.unit)
        cell.nutrientAmountLabel.text = amountString
        return cell
    }
    
}

