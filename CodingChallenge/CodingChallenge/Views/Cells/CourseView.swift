//
//  CourseCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CourseView: UIView {

    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet private var startTimeLabel: UILabel!
    @IBOutlet private var endTimeLabel: UILabel!
    @IBOutlet private var courseLabel: UILabel!
    @IBOutlet private var tutorLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    @IBOutlet weak var seperateView: UIView!
    
    func configureCell(_ model: HomeCellModel) {
        guard let model = model as? CourseCellModel else { return }
        startTimeLabel.text = model.startTime
        endTimeLabel.text = model.endTime
        courseLabel.text = model.course
        tutorLabel.text = model.tutor
        locationLabel.text = model.location
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }

    init() {
        super.init(frame: .zero)
        fromNib()
        // TODO: Set gradient for the label
        todayLabel.layer.cornerRadius = 3
        todayLabel.layer.masksToBounds = true
    }

}

struct CourseCellModel: HomeCellModel {
    var startTime: String
    var endTime: String
    var course: String
    var tutor: String
    var location: String
}
