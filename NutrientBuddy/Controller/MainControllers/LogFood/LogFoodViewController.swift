//
//  logFoodViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 24/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit
import MessageUI

class LogFoodViewController: UIViewController, MFMailComposeViewControllerDelegate {
    //MARK: loading database
    var database: [FoodInfo] = []
    var dictViewCont: [String:[String]] = [:]
    var categoryViewCont: [String] = []
    var codeDict: [String: [Int]] = [:]

    override func viewDidAppear(_ animated: Bool) {
        if debugViewLoading {
             print("GJ: got back to myMeal at \(Date())")
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        database = foodData().loadFoodDatabase()!
        dictViewCont = foodData().categorizeItems()
        categoryViewCont = foodData().categorizeItems().keys.sorted(by: <)
        codeDict = BagOfWord().loadDictionary()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: send emails
    @IBAction func shareUserData(_ sender: UIBarButtonItem) {
        let nutrientToView = NutrientTypeCoreDataHandler.fetchObject()
        let diary = NutrientDiaryCoreDataHandler.fetchObject()
        let summary = SummaryDiaryCoreDataHandler.fetchAllObject()
        let goals = PersonalSettingCoreDataHandler.fetchObject()
        
        let ntv_csvString = LoadAttachment().writeCoreDataObjToCSV(object: nutrientToView!, named: "NutrientToView.csv")
        let diary_csvString = LoadAttachment().writeCoreDataObjToCSV(object: diary!, named: "Diary.csv")
        let smy_csvString = LoadAttachment().writeCoreDataObjToCSV(object: summary, named: "Summary.csv")
        let goal_csvString = LoadAttachment().writeCoreDataObjToCSV(object: goals!, named: "Goal.csv")
        
        let string = ntv_csvString + diary_csvString + smy_csvString + goal_csvString
        let data = string.data(using: .utf8)
        let mailComposeController = configureMailController(data: data!)
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeController, animated: true, completion: nil)
        }
        else {
            showMailError()
        }
    }
   
    func configureMailController(data:Data) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["tj294@cam.ac.uk"])
        mailComposerVC.setSubject("Nutrient Buddy - UserInformation")
        
        mailComposerVC.addAttachmentData(data, mimeType: "text/csv", fileName: "userInfo.csv")
        return mailComposerVC
    }
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Couldn't send the email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: pass to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // SearchViewControlller
        if segue.identifier == "loadSearchPageBreakfast" {
            let searchViewController: SearchViewController = segue.destination as! SearchViewController
            searchViewController.codeDict = codeDict
            searchViewController.database = database
            searchViewController.catDict = dictViewCont
            searchViewController.catCategories = categoryViewCont
        }
        if segue.identifier == "loadSearchPageLunch" {
            let searchViewController: SearchViewController = segue.destination as! SearchViewController
            searchViewController.codeDict = codeDict
            searchViewController.database = database
            searchViewController.catDict = dictViewCont
            searchViewController.catCategories = categoryViewCont
        }
        if segue.identifier == "loadSearchPageDinner" {
            let searchViewController: SearchViewController = segue.destination as! SearchViewController
            searchViewController.codeDict = codeDict
            searchViewController.database = database
            searchViewController.catDict = dictViewCont
            searchViewController.catCategories = categoryViewCont
        }
        if segue.identifier == "loadSearchPageSnack" {
            let searchViewController: SearchViewController = segue.destination as! SearchViewController
            searchViewController.codeDict = codeDict
            searchViewController.database = database
            searchViewController.catDict = dictViewCont
            searchViewController.catCategories = categoryViewCont
        }
    }
}

