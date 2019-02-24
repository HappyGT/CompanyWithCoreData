//
//  CompanyCell.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 20..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .tealColor
        
        addSubview(companyImageView)
        companyImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        companyImageView.layer.cornerRadius = 40 / 2
        
        addSubview(nameFoundedDateLabel)
        nameFoundedDateLabel.anchor(top: nil, leading: companyImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 40))
        nameFoundedDateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
