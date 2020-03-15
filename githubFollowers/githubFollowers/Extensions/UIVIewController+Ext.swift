//
//  UIVIewController+Ext.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/3/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit
import SafariServices




extension UIViewController {
    
    
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemTeal
        present(safariVC, animated: true)
    }
    

}
