//
//  MainVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/1/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GitHubTextField()
    let gitHubButton = GitHubButton(backgroundColor: .systemGreen, title: "Find Followers")
    
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,usernameTextField,gitHubButton)
        setUpKeyboardTapGesture()
        setUpLogoImageView()
        setUpTextField()
        setUpGitHubButton()


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true  )
    }
    
    func setUpKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    @objc func pushFollowersVC() {
        
        guard isUsernameEntered else {  
            presentAlertOnMainThread(title: "Empty Username", message: "Please try again.", buttonTitle: "Ok")
            return
            
        }
        usernameTextField.resignFirstResponder()
        
        let followersListVC = FollowersVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    func setUpLogoImageView() {
        //Instantiating view
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        //Checks against small sized screens
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
                
        //Layout with 4 constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    func setUpTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    func setUpGitHubButton() {
        gitHubButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            gitHubButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            gitHubButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            gitHubButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            gitHubButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    



}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        return true
    }
}
