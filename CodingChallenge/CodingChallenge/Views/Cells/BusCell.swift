//
//  BusCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class BusCell: UITableViewCell {

    @IBOutlet weak var topTrailling: NSLayoutConstraint!
    @IBOutlet weak var bottomTrailing: NSLayoutConstraint!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var predictedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundView?.backgroundColor = UIColor(hexString: Color.gray)
        
    }
    
    func setupCell(departure: String, arrival: String, predictedTime: String) {
        departureLabel.text = departure
        arrivalLabel.text = arrival
        predictedTimeLabel.text = predictedTime
    }
}
