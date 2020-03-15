//
//  TabBarVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/11/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemTeal
        viewControllers = [createMainNC(), createFavoritesNC()]

    }
    
    func createMainNC() -> UINavigationController {
        let mainVC = MainVC()
        mainVC.title = "Search"
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: mainVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    


}
