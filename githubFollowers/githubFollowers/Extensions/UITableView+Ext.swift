//
//  UITableView+Ext.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/13/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
