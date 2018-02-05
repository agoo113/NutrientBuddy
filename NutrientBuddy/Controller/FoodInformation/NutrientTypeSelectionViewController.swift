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
            NutrientTypeCoreDataHandler.changeSelection(nutrient: singleNutrient, select: 1)
        } else {
            NutrientTypeCoreDataHandler.changeSelection(nutrient: singleNutrient, select: 0)
        }
        
    }

    // Mark: Done
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func redoButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Alert", message: "Reset nutrient selection to default", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            NutrientTypeCoreDataHandler.clearnDelete()
            self.nutrients = NutrientTypeCoreDataHandler.fetchObject()!
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}
