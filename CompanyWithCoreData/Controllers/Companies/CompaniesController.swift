//
//  CompaniesController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 9..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {

    let cellId = "cellId"
    var companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Facebook", founded: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        setupNavigation()
    }

    fileprivate func setupTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    @objc fileprivate func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavController(rootViewController: createCompanyController)
        
        present(navController, animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    
}

