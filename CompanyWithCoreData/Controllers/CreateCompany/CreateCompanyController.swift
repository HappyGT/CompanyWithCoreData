//
//  CreateCompanyController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 9..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    var delegate: CreateCompanyControllerDelegate?
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        
        return textField
    }()
    
    let foundedLabel: UILabel = {
        let label = UILabel()
        label.text = "Founded"
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        
        setupNavigation()
        setupUI()
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave() {
        
        if company == nil {
            createCompany()
        } else {
            saveChangedCompany()
        }

        
        
    }
    
    private func createCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        newCompany.setValue(nameTextField.text, forKey: "name")
        

        do {
            if context.hasChanges {
                try context.save()
                
                dismiss(animated: true) {
                    self.delegate?.didAddCompany(company: newCompany as! Company)
                }
            }
        } catch let saveErr {
            print("Failed to save new company: ", saveErr)
        }
    }
    
    private func saveChangedCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        company?.name = nameTextField.text
        
        do {
            if context.hasChanges {
                try context.save()
                dismiss(animated: true) {
                    guard let changedCompany = self.company else { return }
                    self.delegate?.didEditCompany(company: changedCompany)
                }
            }
        } catch let saveErr {
            print("Failed to save changed company: ", saveErr)
        }
    }
    
    fileprivate func setupUI() {
        let backgroundView = LightBlueBackgroundView()
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 300))
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 80, height: 50))
        
        view.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.topAnchor, leading: nameLabel.trailingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
