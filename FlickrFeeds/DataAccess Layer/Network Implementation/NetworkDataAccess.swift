//
//  NetworkDataAccess.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 11/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

class NetworkDataAccess {
    
    fileprivate let synchronizer: Synchronizer
    fileprivate let baseURL: URL
    
    init(baseURL: URL, cacheTime: TimeInterval) {
        self.baseURL = baseURL
        self.synchronizer = Synchronizer(cacheTime: cacheTime)
    }
}

extension NetworkDataAccess: DataAccess {
    
    func feedsWithQuery(_ q: String, pageSize: Int, completion: @escaping (FeedResult<[Feed]>) -> Void) {
        // cancel previous session
        synchronizer.cancelSession()
        
        let resource = FeedResource(baseURL: baseURL, searchText: q, page: nil, pageSize: nil)
        synchronizer.loadPagedResource(resource, pageSize: pageSize, completion: completion)
    }
}

extension FeedResource: PageResources {
    
    func resourceForPage(_ page: Int, pageSize: Int) -> FeedResource {
        return FeedResource(
            baseURL: baseURL,
            searchText: searchText,
            page: page,
            pageSize: pageSize)
    }
    
    func isLastPage(_ totalPages: Int, current: Int) -> Bool {
        return current == totalPages
    }
}
