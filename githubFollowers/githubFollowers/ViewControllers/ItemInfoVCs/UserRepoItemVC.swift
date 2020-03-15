//
//  UserRepoItemVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/10/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

protocol UserRepoDelegate: class {
    func didTapProfile(for user: User)
}

class UserRepoItemView: InfoVC {
    
    weak var delegate: UserRepoDelegate!
    
    init(user: User, delegate: UserRepoDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
        
    }
    
    private func setUpItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        
    }
    override func actionButtonTapped() {
        delegate.didTapProfile(for: user)
    }
}
