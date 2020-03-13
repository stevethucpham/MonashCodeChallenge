//
//  BusCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class BusView: UIView {


    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var predictedTimeLabel: UILabel!
    @IBOutlet weak var seperateView: UIView!

    
    func configureCell(_ model: BusCellModel) {
        departureLabel.text = model.departure
        arrivalLabel.text = model.arrival
        
        let date = Date(model.predictedDateTime)
        let timeDifference = date.timeDifference(since: Date())
        predictedTimeLabel.text = timeDifference
    }
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
           fatalError()
       }

       init() {
           super.init(frame: .zero)
           fromNib()
       }
}

struct BusCellModel: HomeCellModel {
    var departure: String
    var arrival: String
    var predictedDateTime: String
    
}
