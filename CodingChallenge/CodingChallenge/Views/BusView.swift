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

    
    /// Configure cell with cell model
    /// - Parameter model: BusCellModel
    func configureCell(_ model: BusCellModel) {
        departureLabel.text = model.departure
        arrivalLabel.text = model.arrival
    
        let systemService = SystemService()
        
        let timeDifference = model.predictedDateTime.timeDifference(since: systemService.now)
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
    
    /// Departure stop
    var departure: String
    
    /// Arrival stop
    var arrival: String
    
    /// Predicted arrival time
    var predictedDateTime: Date
    
}
