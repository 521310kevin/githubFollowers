//
//  PersistanceManager.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/10/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "Favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping(GitHubError?) -> Void ) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.unableToFavorite)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll{ $0.login == favorite.login}
                }
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
            
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GitHubError>) -> Void) {
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do  {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoriteData)
            completed(.success(favorites))
        } catch {
            completed(.failure( .unableToFavorite))
        }
        
        
        
    }
    
    static func save(favorites: [Follower]) -> GitHubError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
        
        
    }
}
