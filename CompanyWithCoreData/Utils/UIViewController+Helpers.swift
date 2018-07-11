//
//  UIViewController+Helpers.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 7. 11..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handelCancel))
    }
    
    @objc func handelCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightBlue
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: height))
        
        return backgroundView
    }
    
}
