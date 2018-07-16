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
    var employees = [Employee]()
    
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
    
    private func fetchEmployees() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//
//        let request = NSFetchRequest<Employee>(entityName: "Employee")
//
//
//        do {
//            let employees = try context.fetch(request)
//            self.employees = employees
//
//            employees.forEach { print("name:", $0.name ?? "") }
//
//        } catch let err {
//            print("Failed to fetch employees ", err)
//        }
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        self.employees = companyEmployees
    }

    @objc private func handelAdd() {
        let createEmployeeController = CreateEmployeeController()
        let navController = CustomNavController(rootViewController: createEmployeeController)
        
        createEmployeeController.company = self.company
        createEmployeeController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
    
    
 
    
    
    
    
    
}
