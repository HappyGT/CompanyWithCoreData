//
//  CompaniesController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 9..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {

    let cellId = "cellId"
    var companies = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.companies = CoreDataManager.shared.fetchCompanies()
        
        setupTableView()
        setupNavigation()
    }

    private func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupNavigation() {
        navigationItem.title = "Companies"
        
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    @objc private func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        
        present(navController, animated: true, completion: nil)
    }

    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companies.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)

        } catch let deleteErr {
            print("Failed to delete object from Core Data: ", deleteErr)
        }
    }

    
}

