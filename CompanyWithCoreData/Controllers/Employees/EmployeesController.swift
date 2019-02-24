//
//  EmployeesController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 11..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController {
    var company: Company?
    var allEmployees = [[Employee]]()
    
    var employees = [Employee]()
    var employeeTypes = [
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagement.rawValue,
        EmployeeType.Staff.rawValue
    ]
    
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        tableView.backgroundColor = .darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupPlusButtonInNavBar(selector: #selector(handelAdd))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    func fetchEmployees() {

        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        allEmployees = []
        employeeTypes.forEach { (employeeType) in
            allEmployees.append(companyEmployees.filter{ $0.type == employeeType })
        }
    }

    @objc private func handelAdd() {
        let createEmployeeController = CreateEmployeeController()
        let navController = CustomNavController(rootViewController: createEmployeeController)
        
        createEmployeeController.company = self.company
        createEmployeeController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    
 
    
    
    
    
    
}
