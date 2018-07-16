//
//  EmployeesController+Delegate.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 13..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

extension EmployeesController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        
        let newIndexPath = IndexPath(row: employees.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let employee = self.employees[indexPath.row]
        
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
