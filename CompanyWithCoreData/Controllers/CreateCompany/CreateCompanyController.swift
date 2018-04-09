//
//  CreateCompanyController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 9..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit


class CreateCompanyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        
        setupNavigation()
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
