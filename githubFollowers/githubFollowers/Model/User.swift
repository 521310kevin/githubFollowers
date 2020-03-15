//
//  User.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/4/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var email: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
