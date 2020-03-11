//
//  CourseHeaderView.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CourseHeaderView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
       
       private func commonInit() {
           Bundle.main.loadNibNamed("CourseHeaderView", owner: self, options: nil)
           contentView.frame = self.bounds
           addSubview(contentView)
       }
}
