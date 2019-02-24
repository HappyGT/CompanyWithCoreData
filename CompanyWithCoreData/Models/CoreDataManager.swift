//
//  CoreDataManager.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 10..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompanyModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err.localizedDescription)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let fetchErr {
            print("Failed to fetch companies: ", fetchErr)
            return []
        }
    }
    
    func createEmployee(employeeName: String?, birthdayDate: Date?, employeeType: String?, company: Company) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.company = company
        employee.type = employeeType
        employee.setValue(employeeName, forKey: "name")
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
//        employeeInformation.texId = "125"
        employeeInformation.birthday = birthdayDate
        
        employee.employeeInfomation = employeeInformation
        
        do {
            try context.save()
            return (employee, nil)
        } catch let saveErr {
            print("Failed to create employee:", saveErr)
            return (nil, saveErr)
        }
    }
}
