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
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return presenter.getNumberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard HomeSection.allCases.count > section else { return 0 }
        let homeSection = HomeSection.allCases[section]
        return presenter.getNumberOfRows(for: homeSection)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard HomeSection.allCases.count > indexPath.section else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeSection.cellIdentifier, for: indexPath) as? CourseCell else { return UITableViewCell() }
        let homeSection = HomeSection.allCases[indexPath.section]
        let models = presenter.getItems(for: homeSection)
        switch homeSection {
        case .parking:
            let parkingModels: [ParkingCellModel] = mapCourseModel(models)
            cell.configureParkingView(parkingModels)
            break
        case .schedule:
            let courseModels: [CourseCellModel] = mapCourseModel(models)
            cell.configureCourseView(courseModels)
            break
        case .busSchedule:
             let busModels: [BusCellModel] = mapCourseModel(models)
             cell.configureBusView(busModels)
            break
        }
    
        cell.backgroundColor = .clear
        return cell
    }
    
    // MARK: TableView delegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard HomeSection.allCases.count > section else { return 0 }
        let homeSection = HomeSection.allCases[section]
        if presenter.getNumberOfRows(for: homeSection) == 0 || homeSection == .schedule {
            return 0
        }
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let homeSection = HomeSection.allCases[section]
        if presenter.getNumberOfRows(for: homeSection) == 0 {
            return nil
        }
        let title = UILabel(frame: CGRect(x: 15, y: 20, width: tableView.bounds.size.width, height: 20))
        title.text = homeSection.title
        title.textColor = .darkGray
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 0))
        
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
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}
// MARK: HomeDisplay binding UI 
extension ScheduleViewController: HomeDisplay {
    func errorDisplay(message: String) {
        DispatchQueue.main.async {
            self.alert(title: "Error", message: message, okButtonTitle: "Ok")
        }
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    
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

