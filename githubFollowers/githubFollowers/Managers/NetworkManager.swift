//
//  NetworkManager.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/4/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit

class NetworkManager {
    //Singleton
    static let shared = NetworkManager()
    private let baseURL =  "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    private init() {
        
    }
    
    //@escaping outlives the function incase bad internet
    func getFollowers(for username: String, page: Int, completionHandler: @escaping(Result<[Follower], GitHubError>) -> Void) {
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure( .invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure( .unableToComplete))
            }
            //HTTP respponse code, check for 200
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure( .invalidResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure( .invalidData))
                return
            }
            do  {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            } catch {
                completionHandler(.failure( .invalidData))
            }
        }
        task.resume()
        
    }
    
    func getUsers(for username: String, completionHandler: @escaping(Result<User, GitHubError>) -> Void) {
        let endPoint = baseURL + "\(username)"
        guard let url = URL(string: endPoint) else {
            completionHandler(.failure( .invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completionHandler(.failure( .unableToComplete))
            }
            //HTTP respponse code, check for 200
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure( .invalidResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure( .invalidData))
                return
            }
            do  {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completionHandler(.success(user))
            } catch {
                completionHandler(.failure( .invalidData))
            }
        }
        task.resume()
        
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }

            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
