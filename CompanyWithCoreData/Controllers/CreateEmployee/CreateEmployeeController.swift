//
//  CreateEmployeeController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 11..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit


protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var company: Company?
    var delegate: CreateEmployeeControllerDelegate?

    
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
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        
        return label
    }()
    
    private let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "yyyy/MM/dd"
        
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
        
        view.addSubview(birthdayLabel)
        birthdayLabel.anchor(top: nameLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 80, height: 50))
        view.addSubview(birthdayTextField)
        birthdayTextField.anchor(top: birthdayLabel.topAnchor, leading: birthdayLabel.trailingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        
        
    }
    
    @objc private func handleSave() {
        guard let company = self.company else { return }
        guard let birthdayText = birthdayTextField.text else { return }
        
        if birthdayText.isEmpty {
            showError(title: "Empty Birthday", message: "You have not entered a birthday.")
            return
        }
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy/MM/dd"
        guard let birthdayDate = dateFomatter.date(from: birthdayText) else {
            showError(title: "Bad Date", message: "Birthday date entered not valid")
            return
        }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: nameTextField.text,
                                                          birthdayDate: birthdayDate,
                                                          company: company)
        
        guard let employee = tuple.0 else { return }
        
        if let error = tuple.1 {
            print(error)
        
        } else {
            dismiss(animated: true) {
                
                self.delegate?.didAddEmployee(employee: employee)
            }
            
        }
    }
    
    
    private func showError(title: String, message: String) {
        let alartController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alartController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alartController, animated: true, completion: nil)
    }
    
    
}














