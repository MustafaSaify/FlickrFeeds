//
//  FeedResult.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 10/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum FeedResult<Page> {
    case success(page: Page, nextPageIfNotLast: LoadPageBlock?)
    case feedEnd
    case error(error: Error, retry: LoadPageBlock)
    
    typealias LoadPageBlock = (_ completion: @escaping (FeedResult<Page>) -> Void) -> Void
}
