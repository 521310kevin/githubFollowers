//
//  InfoVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/10/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

protocol InfoVCDelegate: class {
    func didTapProfile(for user: User)
    func didTapFollowers(for user: User)
}


class InfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = ItemInfoView()
    let itemInfoViewTwo = ItemInfoView()
    let actionButton = GitHubButton(backgroundColor: .systemTeal, title: "")
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackgroundView()
        setUpActionButton()
        layoutUI()
        setUpStackView()

    }
    
    private func setUpBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
    }
    
    private func setUpStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func setUpActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        
    }
    
    private func layoutUI(){
        view.addSubviews(stackView, actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            actionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }

}
