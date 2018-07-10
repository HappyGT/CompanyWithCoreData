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

class CreateCompanyController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: CreateCompanyControllerDelegate?
    var company: Company? {
        didSet {
            if let companyData = company?.imageData {
                companyImageView.image = UIImage(data: companyData)
                setupCircularImageViewStyle()
            }
            
            nameTextField.text = company?.name
            
            if let foundedDate = company?.founded {
                foundedDatePicker.date = foundedDate
            }
        }
    }
    
    private func setupCircularImageViewStyle() {
        companyImageView.layer.cornerRadius = companyImageView.bounds.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderColor = UIColor.darkBlue.cgColor
        companyImageView.layer.borderWidth = 2.0
    }
    
    private lazy var companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        
        return imageView
    }()
    
    @objc private func handleSelectPhoto() {
        let imagePickerController = redStyleImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func redStyleImagePickerController() -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.navigationBar.isTranslucent = false
        imagePickerController.navigationBar.barTintColor = .lightRed
        imagePickerController.navigationBar.tintColor = .white
        imagePickerController.navigationBar.prefersLargeTitles = true
        imagePickerController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        imagePickerController.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        return imagePickerController
    }
    
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
    
    private let foundedLabel: UILabel = {
        let label = UILabel()
        label.text = "Founded"
        
        return label
    }()
    
    private let foundedDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        
        return dp
    }()

    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        
        setupNavigation()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupNavigation() {
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
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
        newCompany.setValue(foundedDatePicker.date, forKey: "founded")
        if let companyImage = companyImageView.image {
            if let imageData = UIImageJPEGRepresentation(companyImage, 0.8) {
                newCompany.setValue(imageData, forKey: "imageData")
            }
        }

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
        company?.founded = foundedDatePicker.date
        if let companyImage = companyImageView.image {
            if let imageData = UIImageJPEGRepresentation(companyImage, 0.8) {
                company?.imageData = imageData
            }
        }
        
        do {
            if context.hasChanges {
                try context.save()
                
                // Success
                dismiss(animated: true) {
                    guard let changedCompany = self.company else { return }
                    self.delegate?.didEditCompany(company: changedCompany)
                }
            }
        } catch let saveErr {
            print("Failed to save changed company: ", saveErr)
        }
    }
    
    //MARK:-
    private func setupUI() {
        let backgroundView = LightBlueBackgroundView()
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 350))
        
        view.addSubview(companyImageView)
        companyImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        companyImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: companyImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 16, bottom: 0, right: 0), size: .init(width: 80, height: 50))
        view.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.topAnchor, leading: nameLabel.trailingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        view.addSubview(foundedDatePicker)
        foundedDatePicker.anchor(top: nameLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: backgroundView.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .zero)
    
        
    }
    
    //MARK:- ImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            companyImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            companyImageView.image = originalImage
        }
        setupCircularImageViewStyle()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
