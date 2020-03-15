//
//  GitHubTitleLabel.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/3/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class GitHubTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()

        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Requires designated init
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont(name: "Spartan", size: fontSize)
    }
    
    func setUp() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
