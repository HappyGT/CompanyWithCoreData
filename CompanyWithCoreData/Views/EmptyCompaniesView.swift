//
//  EmptyCompaniesView.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 15..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class EmptyCompaniesView: UIView {
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "No companies available", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.attributedText = attributedString
        label.textAlignment = .center
      
        return label
    }()
    
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please create some companies by using the Add Button near the top."
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(detailTitleLabel)
        detailTitleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 0))
        
        addSubview(mainTitleLabel)
        mainTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: detailTitleLabel.topAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
