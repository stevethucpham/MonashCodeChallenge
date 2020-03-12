//
//  CardView.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth = 0
    @IBInspectable var shadowOffsetHeight = 1.5
    @IBInspectable var shadowColor = UIColor.black
    @IBInspectable var shadowOpacity = 0.3
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: .zero, height: shadowOffsetHeight)
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowRadius = 2
//        layer.shadowPath = shadowPath.cgPath
    }
    
}
