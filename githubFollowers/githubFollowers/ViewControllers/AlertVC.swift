//
//  AlertVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/3/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView = AlertContainerView()
    let titleLabel = GitHubTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GitHubBodyLabel(textAlignment: .left)
    let dismissButton = GitHubButton(backgroundColor: .systemTeal, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(containerView, titleLabel , messageLabel, dismissButton)
        setUpContainerView()
        setUpTitleView()
        setUpButton()
        setUpBodylabel()
        blurBackground()


    }
    func blurBackground() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
    }
    func setUpContainerView() {
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])

        
    }
    func setUpTitleView() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    func setUpButton() {
        dismissButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            dismissButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func setUpBodylabel() {
        messageLabel.text = message ?? "Unknown"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -12)
        ])
    }
    



}
