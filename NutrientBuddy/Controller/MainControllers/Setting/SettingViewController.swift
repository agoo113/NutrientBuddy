//
//  SettingViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 26/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let goals = PersonalSettingCoreDataHandler.fetchObject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func saveButtonItemTapped(_ sender: UIBarButtonItem) {
       
    }
    
    //MARK: table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientSetting")
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalSetting")
        return cell!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
