//
//  ScheduleViewController.swift
//  CodingChallenge
//
//  Created by iOS Developer on 3/12/20.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {

    let presenter = HomePresenter()
    let navigationView = NavigationTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        presenter.display = self

        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return presenter.getNumberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard HomeSection.allCases.count > section else { return 0 }
//        let homeSection = HomeSection.allCases[section]
//        return presenter.getNumberOfRows(for: homeSection)
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard HomeSection.allCases.count > indexPath.section else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeSection.cellIdentifier, for: indexPath) as? CourseCell else { return UITableViewCell() }
        
        
        let homeSection = HomeSection.allCases[indexPath.section]
        
        let models = presenter.getItems(for: homeSection)
    
        switch homeSection {
        case .parking:
            
            let parkingModels: [ParkingCellModel] = mapCourseModel(models)
            
            for item in parkingModels {
                let parkingView = ParkingView()
                parkingView.frame = CGRect(x: 0, y: 0, width: cell.stackView.frame.width, height: 75)
                parkingView.configureCell(item)
                cell.stackView.addArrangedSubview(parkingView)
            }
            
            break
        case .schedule:
            break
        case .busSchedule:
            break
        }
        
//        switch (cell, model) {
//        case (let cell as ParkingCell, let model as ParkingCellModel):
//            cell.configureCell(model)
//            break
//        case (let cell as CourseCell, let model as CourseCellModel):
//            cell.configureCell(model)
//            break
//        case (let cell as BusCell, let model as BusCellModel):
//            cell.configureCell(model)
//            break
//        default:
//            return UITableViewCell()
//        }
//
        cell.backgroundColor = .clear
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let homeSection = HomeSection.allCases[section]
        return homeSection.title
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let homeSection = HomeSection.allCases[section]
        let title = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.size.width, height: 30))
        title.text = homeSection.title
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
        
        headerView.backgroundColor = .clear
        headerView.addSubview(title)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


}

// MARK: Private methods
extension ScheduleViewController {
 
    private func setupNavigationView() {
        navigationItem.titleView = navigationView
        navigationController?.hideHairline()
        navigationController?.navigationBar.barTintColor = UIColor(hexString: Color.gray)
    }
    
}

extension ScheduleViewController: HomeDisplay {
    
    func set(name: String, date: String) {
        navigationView.title = name
        navigationView.subTitle = date

    }
}

func mapCourseModel<T>(_ models: [HomeCellModel]) -> [T] {
    return models.compactMap {
        guard let model = $0 as? T else { return nil }
        return model
    }
}


func createViewForModel(_ models: [T]) -> [U] {
    
}
