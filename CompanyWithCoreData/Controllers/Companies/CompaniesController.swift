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
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset)),
            UIBarButtonItem(title: "Nested Work", style: .plain, target: self, action: #selector(doNestedUpdate))
        ]
    }
    
    @objc private func doNestedUpdate() {
        print("Nested Update")
        
        DispatchQueue.global(qos: .background).async {
            
            // first construct a custom MOC
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
            
            // execute update on privateContext now
            let request: NSFetchRequest<Company> = Company.fetchRequest()
            request.fetchLimit = 1
            
            do {
                let companies = try privateContext.fetch(request)
                
                companies.forEach({ (company) in
                    print(company.name ?? "")
                    company.name = "D: \(company.name ?? "")"
                })
                
                do {
                    try privateContext.save()
                    
                    DispatchQueue.main.async {
                        
                        do {
                            let context = CoreDataManager.shared.persistentContainer.viewContext
                            if context.hasChanges {
                                try context.save()
                            }
                            
                            self.tableView.reloadData()
                            
                        } catch let finalSaveErr {
                            print("Failed to save main Context:", finalSaveErr)
                        }
                    }
                    
                } catch let saveErr {
                    print("Failed tp save on private context:", saveErr)
                }
            } catch let fetchErr {
                print("Failed tp fetch on private context:", fetchErr)
            }
            
        }

    }
    
    
    @objc private func doUpdate() {
        print("update!!")
        
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (backgroundContext) in
            
            let request: NSFetchRequest<Company> = Company.fetchRequest()
            
            do {
                let companies = try backgroundContext.fetch(request)
                companies.forEach({ (company) in
                    print(company.name ?? "")
                    company.name = "B: \(company.name ?? "")"
                })
                
                do {
                    try backgroundContext.save()
                    
                    DispatchQueue.main.async {
                        CoreDataManager.shared.persistentContainer.viewContext.reset()
                        
                        self.companies = CoreDataManager.shared.fetchCompanies()
                        
                        
                        
                        self.tableView.reloadData()
                    }
                    
                    
                    
                } catch let saveErr {
                    print("Failed to save on background:", saveErr)
                }
                
                
                
            } catch let err {
                print("Failed to fatch companies on background:", err)
            }
            
            
        }
    }
    
    
    
    @objc private func doWork() {
        print("Do work")
        
        CoreDataManager.shared.persistentContainer.performBackgroundTask({ (backgroundContext) in
            (0...5).forEach { (value) in
                print(value)
                let company = Company(context: backgroundContext)
                company.name = String(value)
            }
            
            do {
                try backgroundContext.save()
                DispatchQueue.main.async {
                    self.companies = CoreDataManager.shared.fetchCompanies()
                    self.tableView.reloadData()
                }
                
            } catch let err {
                print("Failed to save:", err)
            }
        })

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

