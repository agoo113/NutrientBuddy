//
//  NutrientTypeSelectionViewController.swift
//  DemoSearch
//
//  Created by Gemma Jing on 27/01/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class NutrientTypeSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nutrients = NutrientTypeCoreDataHandler.fetchObject()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.hidesBarsOnSwipe = true
        self.navigationItem.hidesBackButton = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (nutrients.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientCell")
        let singleNutrient = self.nutrients[indexPath.row]
        cell?.textLabel?.text = singleNutrient.type
        cell?.textLabel?.numberOfLines = 0
        
        let switchView = UISwitch(frame: .zero)
        if singleNutrient.select == Int16(0) {
            switchView.setOn(false, animated: true)
        } else {
            switchView.setOn(true, animated: true)
        }
        
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell?.accessoryView = switchView
        return cell!
    }
    
    @objc func switchChanged(_ sender: UISwitch!){
        let singleNutrient = nutrients[sender.tag]
       
        if sender.isOn {
            NutrientTypeCoreDataHandler.changeSelection(nutrientToView: singleNutrient, select: 1)
        } else {
            NutrientTypeCoreDataHandler.changeSelection(nutrientToView: singleNutrient, select: 0)
        }
        
    }

    // Mark: Done
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        print("GJ: log time")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logFoodViewController = storyBoard.instantiateViewController(withIdentifier: "myMeals") as! LogFoodViewController
        self.navigationController?.pushViewController(logFoodViewController, animated: true)
    }
}
