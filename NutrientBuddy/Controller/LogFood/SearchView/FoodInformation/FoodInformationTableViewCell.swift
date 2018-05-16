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
    
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var measureUnitLabel: UILabel!
    
    var sliderMaxValue: Float = 200
    var amount: Double = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amountSlider.minimumValue = 0
    }
    
    @IBAction func amountSliderChange(_ sender: UISlider) {
        amountSlider.maximumValue = sliderMaxValue
        amount = Double(sender.value)
        amountLabel.text = "Amount: "
        amountLabel.text?.append(String(format: "%.0f", amount))
    }
}

//MARK: elememt of second cell -- nutrient amounr display
class FoodInformationSecondTableViewCell: UITableViewCell {
    @IBOutlet weak var nutrientTypeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
