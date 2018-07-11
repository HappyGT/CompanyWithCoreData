//
//  EmployeesController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 11..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    var company: Company?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .blue
        
        setupPlusButtonInNavBar(selector: #selector(handelAdd))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = company?.name
    }
    
    @objc private func handelAdd() {
        let createEmployeeController = CreateEmployeeController()
        let navController = CustomNavController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
    }
    
}
