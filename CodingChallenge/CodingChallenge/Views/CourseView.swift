//
//  CourseCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CourseView: UIView {

    
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet private var startTimeLabel: UILabel!
    @IBOutlet private var endTimeLabel: UILabel!
    @IBOutlet private var courseLabel: UILabel!
    @IBOutlet private var tutorLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet weak var seperateView: UIView!
    
    
    /// Configure cell with cell model
    /// - Parameter model: HomeCellModel 
    func configureCell(_ model: HomeCellModel) {
        guard let model = model as? CourseCellModel else { return }
        startTimeLabel.text =
            model.startTime.timeIn12HourFormat()
        endTimeLabel.text = model.endTime.timeIn12HourFormat()
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
        setupToDayLabel()
    }
    
    
    private func setupToDayLabel() {
        // Add gradient color
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(hexString: Color.lightPink)!.cgColor, UIColor(hexString: Color.red)!.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = todayView.bounds
        todayView.layer.addSublayer(gradient)
        
        // Add label
        let label = UILabel(frame: todayView.bounds)
        label.text = "TODAY"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        todayView.addSubview(label)
        todayView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner] , radius: 4)
    }

}

struct CourseCellModel: HomeCellModel {
    
    /// Course start time
    var startTime: Date
    
    /// Course end time
    var endTime: Date
    
    /// Course name
    var course: String
    
    /// Tutor of the course
    var tutor: String
    
    /// Location where students study
    var location: String
}
