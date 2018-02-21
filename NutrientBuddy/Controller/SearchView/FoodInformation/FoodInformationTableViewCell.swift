//
//  FoodInformationTableViewCell.swift
//  DemoSearch
//
//  Created by Gemma Jing on 11/11/2017.
//  Copyright © 2017 Gemma Jing. All rights reserved.
//

import UIKit
//MARK: element of the first cell
class FoodInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    
    var amount: Double = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        amountSlider.minimumValue = 0
        amountSlider.maximumValue = 100
        //amountSlider.addTarget(self, action: #selector(sliderDidEndSliding), for: .touchUpInside)
    }
    
    @objc func sliderDidEndSliding(sender: UISlider) {
        /*let alert = UIAlertController(title: "Nutrient Buddy", message: "Do you want to save this item?", preferredStyle: UIAlertControllerStyle.alert)
        let actionOkay = UIAlertAction(title: "OK", style: .default) { (_) in
            let amount = Double(self.amountSlider.value)
            NutrientDiary().saveDiaryToCoredata(savedFood: self.foodItem, amount: amount)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in
            print("GJ: canceled adding food item")
        }
        alert.addAction(actionOkay)
        alert.addAction(actionCancel)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)*/
        
    }
    
    @IBAction func amountSliderChange(_ sender: UISlider) {
        amount = Double(sender.value)
        amountLabel.text = "Amount: "
        amountLabel.text?.append(String(format: "%.1f", amount))
        amountLabel.text?.append("(g)")
        
    }
}

//MARK: elememt of second cell -- nutrient amounr display
class FoodInformationSecondTableViewCell: UITableViewCell {
    @IBOutlet weak var nutrientTypeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
