//
//  ViewController.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/10/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = HomeViewModel()
        setupNavigationView()
        setupTableView()
    }
    
}

// MARK: Private method
extension HomeViewController {
    
    private func setupNavigationView() {
        let navigationView = NavigationTitleView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationView.title = "Hey, Kier"
        navigationView.subTitle = "17/05 Tuesday, Week 8"
        navigationItem.titleView = navigationView
        navigationController?.hideHairline()
        navigationController?.navigationBar.barTintColor = UIColor(hexString: Color.gray)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor(hexString: Color.gray)
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: "BusCell")
    }
}
