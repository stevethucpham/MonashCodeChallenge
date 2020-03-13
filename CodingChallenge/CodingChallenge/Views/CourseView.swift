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
        setupToDayLabel()
    }
    
    private func setupToDayLabel() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(hexString: Color.lightPink)!.cgColor, UIColor(hexString: Color.red)!.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = todayView.bounds
        todayView.layer.addSublayer(gradient)
        
        
        let label = UILabel(frame: todayView.bounds)
        label.text = "TODAY"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        todayView.addSubview(label)
    }

}

struct CourseCellModel: HomeCellModel {
    var startTime: String
    var endTime: String
    var course: String
    var tutor: String
    var location: String
}
