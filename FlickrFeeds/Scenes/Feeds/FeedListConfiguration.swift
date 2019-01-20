//
//  FeedListConfiguration.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol FeedListView {
    var viewModel: FeedListViewModelProtocol! { get set }
}

protocol FeedListViewModelProtocol {
    var service: FeedServices { get set }
    init (withServices services: FeedServices)
    func fetchFeeds(for searchText: String)
}

protocol FeedServices {
    var repository: FeedRepository { get set }
    init(withRepository repository: FeedRepository)
    func getFeeds(for searchText: String, page: Int)
}

protocol FeedRepository {
    func feeds(for searchText: String, page: Int)
}
