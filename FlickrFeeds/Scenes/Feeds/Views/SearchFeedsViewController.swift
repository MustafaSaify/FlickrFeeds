//
//  SearchFeedsViewController.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 09/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class SearchFeedsViewController: UIViewController {

    init(dataAccess: DataAccess, imageAccess: ImageAccess) {
        self.dataAccess = dataAccess
        self.imageAccess = imageAccess
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImmediatelyChildViewController(navController, embeddedInView: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateFeedsVC()
    }
    
    fileprivate let dataAccess: DataAccess
    fileprivate let imageAccess: ImageAccess
    
    // MARK: - Controllers
    fileprivate lazy var feedsVC: FeedListViewController
        = FeedListViewController(searchBar: self.searchBar(),
                                 imageAccess: self.imageAccess)
    fileprivate lazy var navController: UINavigationController
        = UINavigationController(rootViewController: self.feedsVC,
                                 hidesBarsOnSwipe: true)
    
    // MARK: - Search
    fileprivate var searchTerm: String? {
        didSet { updateFeedsVC() }
    }
}

private extension SearchFeedsViewController {
    
    func updateFeedsVC() {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            feedsVC.reset()
            return
        }
        feedsVC.startFeed { limit -> FeedResult<[Feed]>.LoadPageBlock in
            // knowing page limit desired by Items VC, create load function and pass to Items VC
            func load(_ completion: @escaping ((FeedResult<[Feed]>) -> Void)) {
                dataAccess.feedsWithQuery(
                    searchTerm,
                    pageSize: limit,
                    completion: completion)
            }
            return load
        }
    }
}

extension SearchFeedsViewController: UISearchBarDelegate {
    
    func searchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.tintColor = UIColor.myGreyColor()
        searchBar.placeholder = "Search"
        return searchBar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
}

private extension FeedListViewController {
    
    convenience init(searchBar: UISearchBar, imageAccess: ImageAccess) {
        self.init(imageAccess: imageAccess)
        navigationItem.titleView = searchBar
    }
}

private extension UINavigationController {
    
    convenience init(rootViewController: UIViewController, hidesBarsOnSwipe: Bool) {
        self.init(rootViewController: rootViewController)
        self.hidesBarsOnSwipe = hidesBarsOnSwipe
    }
}
