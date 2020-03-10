//
//  ViewController.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/10/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Home Test"
        let navigationView = NavigationTitleView(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        navigationView.title = "Home"
        navigationView.subTitle = "Test"
        navigationItem.titleView = navigationView
    }
}

