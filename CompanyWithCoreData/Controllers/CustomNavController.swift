//
//  CustomNavController.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 9..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationStyle()
    }
    
    fileprivate func setupNavigationStyle() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .lightRed
        self.navigationBar.tintColor = .white
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
