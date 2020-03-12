//
//  BusCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class BusView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var predictedTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(_ model: BusCellModel) {
        departureLabel.text = model.departure
        arrivalLabel.text = model.arrival
        predictedTimeLabel.text = model.predictedTime
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    func setupInit() {
        Bundle.main.loadNibNamed("BusView", owner: self, options: nil)
        containerView.frame = self.bounds
        addSubview(containerView)
    }
}

struct BusCellModel: HomeCellModel {
    var departure: String
    var arrival: String
    var predictedTime: String
}
