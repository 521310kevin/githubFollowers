//
//  ErrorMessage.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/4/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import Foundation

enum GitHubError: String, Error {
    case invalidUsername =  "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete the request. Please check your internet connection and try again."
    case invalidResponse = "Invalid response from server. Please try again or at a later time."
    case invalidData = "The data from the server is invalid. Please try again or at a later time."
    case unableToFavorite = "An error occured while trying to favorite. Please try again."
    case alreadyInFavorites = "This user is already favorites"
}
