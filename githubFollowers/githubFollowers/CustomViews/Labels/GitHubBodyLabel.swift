//
//  GitHubBodyLabel.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/3/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class GitHubBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment

    }
    
    func setUp() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        self.font = UIFont(name: "Spartan", size: 15)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
