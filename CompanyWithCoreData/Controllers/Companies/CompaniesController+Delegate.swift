//
//  CompaniesController+Delegate.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 9..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
    //MARK:- CreateCompanyController Delegate
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didEditCompany(company: Company) {
        if let changedRow = companies.index(of: company) {
            let changedIndexPath = IndexPath(row: changedRow, section: 0)
            tableView.reloadRows(at: [changedIndexPath], with: .middle)
        }
    }
    
    //MARK:- TableView Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyView = EmptyCompaniesView()
        
        return emptyView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: deleteHandlerFunction)
        deleteAction.backgroundColor = .lightRed
        
        return [deleteAction]
    }
    
    private func deleteHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        let company = self.companies[indexPath.row]
        
        self.companies.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(company)
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch let saveErr {
            print("Failed to delete company:", saveErr)
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editSwipeAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, success:(Bool) -> Void) in
            
            let editCompanyController = CreateCompanyController()
            editCompanyController.company = self.companies[indexPath.row]
            editCompanyController.delegate = self
            let navController = CustomNavController(rootViewController: editCompanyController)
            
            success(true)
            self.present(navController, animated: true, completion: nil)
        }
        editSwipeAction.backgroundColor = .darkBlue
        
        let configuration =  UISwipeActionsConfiguration(actions: [editSwipeAction])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyCell
        
        let company = companies[indexPath.row]
        if let name = company.name, let founded = company.founded {
            
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat = "MMM dd, yyyy"
            let dateFomtterString = dateFomatter.string(from: founded)
            
            cell.nameFoundedDateLabel.text = "\(name) - Founded: \(dateFomtterString)"
            
        } else {
            cell.nameFoundedDateLabel.text = company.name
        }
        
        if let imageData = company.imageData {
            cell.companyImageView.image = UIImage(data: imageData)
        } else {
            cell.companyImageView.image = #imageLiteral(resourceName: "select_photo_empty")
        }
        
        return cell
    }
    
}
