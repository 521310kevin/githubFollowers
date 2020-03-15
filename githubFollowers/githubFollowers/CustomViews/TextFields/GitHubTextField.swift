//
//  GitHubTextField.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/2/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class GitHubTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray2.cgColor
        
        textColor = .label
        //Blinking cursor
        tintColor = .label
        textAlignment = .center
        font = UIFont(name: "Spartan", size: 15)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        keyboardType = .default
        returnKeyType = .go
        //Clears textField
        clearButtonMode = .whileEditing
        placeholder = "Enter a Username"
        
        
        
    }

}
