//
//  CourseCell.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CourseView: UIView {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet private var startTimeLabel: UILabel!
    @IBOutlet private var endTimeLabel: UILabel!
    @IBOutlet private var courseLabel: UILabel!
    @IBOutlet private var tutorLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
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
        setupInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    func setupInit() {
        Bundle.main.loadNibNamed("CourseView", owner: self, options: nil)
        containerView.frame = self.bounds
        addSubview(containerView)
    }
    
}

struct CourseCellModel: HomeCellModel {
    var startTime: String
    var endTime: String
    var course: String
    var tutor: String
    var location: String
}
