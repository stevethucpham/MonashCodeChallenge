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
    var parkingName: String
    var parkingSlots: Int
}

extension UIView {
    @discardableResult
    func fromNib<T: UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = bounds
        addSubview(view)
        return view
    }
}
