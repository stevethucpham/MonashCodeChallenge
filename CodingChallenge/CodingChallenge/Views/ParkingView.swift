//
//  ParkingCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class ParkingView: UIView {
    
    @IBOutlet private var parkingLabel: UILabel!
    @IBOutlet private var parkingSlotLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    
    /// Configure cell with the cell model
    /// - Parameter model: ParkingCellModel
    func configureCell(_ model: ParkingCellModel) {
        parkingLabel.text = model.parkingName
        parkingSlotLabel.text = "\(model.parkingSlots)"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(frame: .zero)
        fromNib()
    }

}


struct ParkingCellModel: HomeCellModel {
    
    /// Parking name
    var parkingName: String
    
    /// Number of parking slots
    var parkingSlots: Int
}

