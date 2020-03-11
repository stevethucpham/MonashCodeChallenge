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
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "BusCell", bundle: nil), forCellReuseIdentifier: "BusCell")
    }
}

// MARK: TableView Datasource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath) as! BusCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 
        let busCell = cell as! BusCell
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
    
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            busCell.cardView.roundCorners(corners: nil, radius: 5)
            busCell.topTrailling.constant = 10
            busCell.bottomTrailing.constant = 10
            
            busCell.cardView.layer.masksToBounds = false
            
            busCell.cardView.layer.shadowColor = UIColor.black.cgColor
            busCell.cardView.layer.shadowOpacity = 0.3
            busCell.cardView.layer.shadowOffset =
                CGSize(width: 0.0, height: 1)
            busCell.cardView.layer.shadowRadius = 5
            
        } else if indexPath.row == 0 {
            busCell.cardView.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 5.0)
            busCell.topTrailling.constant = 10
            
            busCell.cardView.layer.masksToBounds = false
            
            busCell.cardView.layer.shadowColor = UIColor.black.cgColor
            busCell.cardView.layer.shadowOpacity = 0.3
            busCell.cardView.layer.shadowOffset =
                CGSize(width: 0.0, height: 1)
            busCell.cardView.layer.shadowRadius = 5
            
            let path = UIBezierPath()

            // Start at the Top Left Corner
            path.move(to: CGPoint(x: 0.0, y: 0.0))

            // Move to the Top Right Corner
            path.addLine(to: CGPoint(x:  busCell.cardView.frame.width, y: 0.0))

            // Move to the Bottom Right Corner
            path.addLine(to: CGPoint(x:  busCell.cardView.frame.width, y:  busCell.cardView.frame.height))

            // Move to the Bottom Left Corner
            path.addLine(to: CGPoint(x: 0.0, y:  busCell.cardView.frame.height))

            // Move to the Close the Path
            path.close()

             busCell.cardView.layer.shadowPath = path.cgPath


        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            busCell.bottomTrailing.constant = 10
            // Corner the bottom only
            busCell.cardView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 5.0)
            
        } else {

        }
        
       
    }
    
}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
