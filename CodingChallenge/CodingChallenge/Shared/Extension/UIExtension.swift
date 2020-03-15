//
//  UINavigationControllerExtension.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}


extension UIView {
    func roundCorners(corners: CACornerMask?, radius: CGFloat) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
        
        guard let corners = corners else {
            return
        }
        
        self.layer.maskedCorners = [corners]
        
    }
    
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

extension UIViewController {
    
    /// Display alert view controller
    /// - Parameters:
    ///   - title: The alert title
    ///   - message: The alert message
    ///   - okButtonTitle: The title of button
    func alert(title: String, message: String, okButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tag = 7777
        let actionOk = UIAlertAction(title: okButtonTitle,
                                     style: .default,
                                     handler: nil)
        
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}


