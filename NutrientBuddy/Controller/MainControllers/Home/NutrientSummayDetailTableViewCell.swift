//
//  homeTableViewCell.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 24/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class NutrientSummayDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nutrientTypeLabel: UILabel!
    @IBOutlet weak var nutrientAmountLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adviceLabel.frame = CGRect(x: 0, y: 0, width: 345, height: 0)
    }
    
}
