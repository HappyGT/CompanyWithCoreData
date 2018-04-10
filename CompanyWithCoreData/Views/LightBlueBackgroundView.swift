//
//  LightBlueBackgroundView.swift
//  CompanyWithCoreData
//
//  Created by LeeYoung Woon on 2018. 4. 10..
//  Copyright © 2018년 YoungWoon Lee. All rights reserved.
//

import UIKit

class LightBlueBackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
