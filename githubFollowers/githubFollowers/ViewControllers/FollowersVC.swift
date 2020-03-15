//
//  FollowersVC.swift
//  githubFollowers
//
//  Created by Kevin Kuo on 3/2/20.
//  Copyright © 2020 Kevin Kuo. All rights reserved.
//

import UIKit



class FollowersVC: DataLoadingVC {
    
    //For hashable
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoading = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        setUpCollectionView()
        getFollowers(username: username, page: page)
        setUpDataSource()
        setUpSearchController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUsers(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case.success(let user):
                self.addUserToFavorites(user: user)
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistanceManager.updateWith(favorite: favorite, actionType: .add)  {
            [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.presentAlertOnMainThread(title: "Success", message: "You have successfully favorited this user.", buttonTitle: "Ok")
                return
            }
            self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    func setUpCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseID)
    }
    
    func setUpSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoading = true
        // [weak self] makes self weak for memory leak
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self]result in
            //unwrapping self
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let followers):
                self.updateUI(with: followers)
                
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Uh Oh", message: error.rawValue, buttonTitle: "Ok")
            }
            
            self.isLoading = false
            

        }
    }
    
    func updateUI(with followers: [Follower]) {
        if followers.count < 100 {
            self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = "This user does not have any followers."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                return
            }
        }
        
        self.updateData(on: self.followers)
    }
    
    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseID, for: indexPath) as! FollowersCell
            cell.set(follower: follower)
            return cell
            
        })
    }
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }

        
    }
    
    
}

extension FollowersVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        //offset needs to be greater than contenHeight - height to trigger
        if offSetY > (contentHeight - height) {
            guard hasMoreFollowers, !isLoading else {
                return
            }
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //First one checks if isSearching is true, second checks if it is false
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destination =  UserVC()
        destination.username = follower.login
        destination.delegate = self
        let navController = UINavigationController(rootViewController: destination)
        present(navController, animated: true)
        
        
    }
    
}
extension FollowersVC: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter( {$0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFollowers)
    }
    
}
extension FollowersVC: UserVCDelegate {
    func didRequestFollowers(for username: String) {
        // Get followers for user
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0,section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
        
    }
    
    
}
