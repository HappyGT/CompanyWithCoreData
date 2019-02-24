//
//  EmployeesController+Delegate.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 13..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        
        let inset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: inset)
        
        super.drawText(in: customRect)
    }
}


extension EmployeesController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
//        employees.append(employee)
//        fetchEmployees()

        guard let section = employeeTypes.index(of: employee.type!) else { return }
        let row = allEmployees[section].count
        let newIndexPath = IndexPath(row: row, section: section)
        
            allEmployees[section].append(employee)
        tableView.insertRows(at: [newIndexPath], with: .middle)
    }
    
    
    //MARK:- TableView Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
    
        label.text = employeeTypes[section]
    
        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
//        let employee = indexPath.section == 0 ? shortNameEmployees[indexPath.row] : longNameEmployees[indexPath.row]
        let employee = allEmployees[indexPath.section][indexPath.row]
        
//        let employee = self.employees[indexPath.row]
        
        cell.textLabel?.text = employee.name
        
        if let birthday = employee.employeeInfomation?.birthday {
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat = "MMM dd, yyyy"
            
            cell.textLabel?.text = "\(employee.name ?? "")   \(dateFomatter.string(from: birthday))"
        }
        
        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        
        
        return cell
    }
}
