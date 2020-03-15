//
//  UserFollowerItemVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/10/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

protocol UserFollowersDelegate: class {
    func didTapFollowers(for user: User)
}

class UserFollowerItemView: InfoVC {
    
    weak var delegate: UserFollowersDelegate!
    
    init(user: User, delegate: UserFollowersDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemTeal, title: "Get Followers")
        
    }
    override func actionButtonTapped() {
        delegate.didTapFollowers(for: user)
    }
}
