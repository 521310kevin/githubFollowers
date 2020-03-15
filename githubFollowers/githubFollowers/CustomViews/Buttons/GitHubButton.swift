//
//  gitHubButton.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/2/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class GitHubButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    //For disabled storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func setUp() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Spartan", size: 15)
        //Sets it to use Autolayout
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
