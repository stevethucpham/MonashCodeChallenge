//
//  BaseViewController.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
//    private let navigationView: UIView = {
//
//        let navigationView = UIView(frame: CGRect(x: 0, y: 0, width: 320 - 32, height: 320))
//
//        let label = UILabel()
//        label.tag = 7777
//        label.backgroundColor = .clear
//        label.font = UIFont.boldSystemFont(ofSize: 16.0)
//        label.textAlignment = .left
//        label.textColor = .black
//        label.text = title
//        label.sizeToFit()
//
//        let label1 = UILabel()
//        label1.tag = 7777
//        label1.backgroundColor = .clear
//        label1.font = UIFont.boldSystemFont(ofSize: 16.0)
//        label1.textAlignment = .left
//        label1.textColor = .black
//        label1.text = title
//        label1.sizeToFit()
//
//        //Stack View
//        let stackView   = UIStackView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
//        stackView.axis  = NSLayoutConstraint.Axis.vertical
//        stackView.distribution  = UIStackView.Distribution.equalSpacing
//        stackView.alignment = UIStackView.Alignment.center
//        stackView.spacing   = 5
//
//        stackView.addArrangedSubview(label)
//        stackView.addArrangedSubview(label1)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//    }()

    override var title: String? {
        didSet {
            guard let title = title else {
                navigationItem.titleView = nil
                return
            }
//            let label = UILabel()
//            label.backgroundColor = .clear
//            label.font = UIFont.boldSystemFont(ofSize: 16.0)
//            label.textAlignment = .left
//            label.textColor = .black
//            label.text = title
//            label.sizeToFit()
//
//            let label1 = UILabel()
//            label1.backgroundColor = .clear
//            label1.font = UIFont.boldSystemFont(ofSize: 16.0)
//            label1.textAlignment = .left
//            label1.textColor = .black
//            label1.text = title
//            label1.sizeToFit()
            
            //Stack View
//            let stackView   = UIStackView()
//            stackView.axis  = NSLayoutConstraint.Axis.vertical
//            stackView.distribution  = UIStackView.Distribution.equalSpacing
//            stackView.alignment = UIStackView.Alignment.center
//            stackView.spacing   = 5
//
//            stackView.addArrangedSubview(label)
//            stackView.addArrangedSubview(label1)
//            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let navigationView = NavigationTitleView(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
            navigationView.title = title
//            navigationItem.title = nil
            navigationItem.titleView = navigationView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
