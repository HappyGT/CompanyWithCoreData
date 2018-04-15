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
    
    
}
