//
//  Date+Ext.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/10/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
