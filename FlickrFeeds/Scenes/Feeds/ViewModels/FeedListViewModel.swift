//
//  FeedListViewModel.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class FeedListViewModel {
    let title = Observable<String>(value: "Loading")
    let isLoading = Observable<Bool>(value: false)
    let isTableViewHidden = Observable<Bool>(value: false)
}
