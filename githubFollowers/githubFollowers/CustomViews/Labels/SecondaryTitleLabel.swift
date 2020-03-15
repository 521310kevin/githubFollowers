//
//  SecondaryTitleLabel.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/8/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class SecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont(name: "Spartan", size: fontSize)
        self.textAlignment = textAlignment

    }
    
    func setUp() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
