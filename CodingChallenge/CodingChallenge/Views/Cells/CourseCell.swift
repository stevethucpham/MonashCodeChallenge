//
//  CourceCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/12/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureParkingView(_ models: [ParkingCellModel]) {
        for (key, item) in models.enumerated() {
            let parkingView = ParkingView()
            parkingView.frame = CGRect(x: 0, y: 0, width: stackView.frame.width, height: 75)
            parkingView.configureCell(item)
            stackView.addArrangedSubview(parkingView)
            parkingView.seperatorView.isHidden = key == models.count - 1
        }
    }
    
    func configureBusView(_ models: [BusCellModel]) {
        for (key, item) in models.enumerated() {
            let busView = BusView()
            busView.frame = CGRect(x: 0, y: 0, width: stackView.frame.width, height: 75)
            busView.configureCell(item)
            stackView.addArrangedSubview(busView)
            busView.seperateView.isHidden = key == models.count - 1
        }
    }
    
    
    func configureCourseView(_ models: [CourseCellModel]) {
        for (key, item) in models.enumerated() {
            let courseView = CourseView()
            courseView.frame = CGRect(x: 0, y: 0, width: stackView.frame.width, height: 75)
            courseView.configureCell(item)
            stackView.addArrangedSubview(courseView)
            courseView.seperateView.isHidden = key == models.count - 1
            courseView.topStackView.isHidden = key != 0
        }
    }
    
    
}
