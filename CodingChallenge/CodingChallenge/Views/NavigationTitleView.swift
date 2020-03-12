//
//  NavigationTitleView.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/11/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class NavigationTitleView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set (newValue) {
            titleLabel.text = newValue
        }
    }
    
    var subTitle: String? {
        get {
            return subTitleLabel.text
        }
        set(newValue) {
            subTitleLabel.text = newValue
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
    }
    
}
