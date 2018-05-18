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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nutrients = HomeViewFunctions().getNutrientToView(nutrientToView: nutrients)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.hidesBarsOnSwipe = true
        let doneButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "doneView"), style: .plain, target: self, action: #selector(doneButtonTapped))
        
        //let resetButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "resetView"), style: .plain, target: self, action: #selector(resetButtonTapped))
        
        //self.navigationItem.rightBarButtonItems = [doneButtonItem, resetButtonItem]
        self.navigationItem.rightBarButtonItem = doneButtonItem
        tableView.reloadData()
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
        if indexPath.row < 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientCellStatic")
            let singleNutrient = self.nutrients[indexPath.row]
            cell?.textLabel?.text = singleNutrient.type
            cell?.textLabel?.numberOfLines = 0
            return cell!
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientCellSelect")
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
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        }
        
        
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
        if debugNutrientSetting {
            let nutrientToView = NutrientTypeCoreDataHandler.fetchObject()
            
            print("GJ: the size of nutrient to view is: \(String(describing: nutrientToView?.count))")
            for each in nutrientToView! {
                print(each)
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*@objc func resetButtonTapped(_ sender: UIBarButtonItem) {
       
        let alert = UIAlertController(title: "Alert", message: "Reset nutrient selection to default", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            NutrientTypeCoreDataHandler.clearnDelete()
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        if debugNutrientSetting {
            let nutrientToView = NutrientTypeCoreDataHandler.fetchObject()
            print("GJ: the size of nutrient to view is: \(String(describing: nutrientToView?.count))")
            for each in nutrientToView! {
                print(each)
            }
        }
        
       
    }
 */
}
