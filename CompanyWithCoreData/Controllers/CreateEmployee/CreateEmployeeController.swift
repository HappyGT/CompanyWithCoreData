//
//  CreateEmployeeController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 11..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        
        setupCancelButtonInNavBar()
        view.backgroundColor = .darkBlue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        setupUI()
    }
    
    private func setupUI() {
        let backgroundView = setupLightBlueBackgroundView(height: 350)
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: backgroundView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 80, height: 50))
        view.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.topAnchor, leading: nameLabel.trailingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
    }
    
    @objc private func handleSave() {
        let err = CoreDataManager.shared.createEmployee(employeeName: nameTextField.text)
        
        if let error = err {
            print(error)
        
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
}














