//
//  Synchronizer+PageResources.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 11/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension Synchronizer {
    
    func loadPagedResource<PR: PageResources>(_ resource: PR, pageSize: Int, completion: @escaping (FeedResult<[PR.PageResource.ParsedObject.Item]>) -> Void) {
        loadPagedResource(resource, pageSize: pageSize, page: 0, completion: completion)
    }
    
    fileprivate func loadPagedResource<PR: PageResources>(_ pagedResource: PR, pageSize: Int, page: Int, completion: @escaping (FeedResult<[PR.PageResource.ParsedObject.Item]>) -> Void) {
        let resource = pagedResource.resourceForPage(page, pageSize: pageSize)
        
        _ = loadResource(resource) { synchronizerResult in
            
            switch synchronizerResult {
            case .success(let result):
                if pagedResource.isLastPage(result.totalPages, current: page) {
                    completion(.success(page: result.items, nextPageIfNotLast: nil))
                } else {
                    let nextPage: FeedResult<[PR.PageResource.ParsedObject.Item]>.LoadPageBlock = { [weak self] completion in
                        self?.loadPagedResource(pagedResource, pageSize: pageSize, page: page + 1, completion: completion)
                    }
                    completion(.success(page: result.items, nextPageIfNotLast: nextPage))
                }
            case .noData:
                completion(.feedEnd)
            case .error(let err):
                let retry: FeedResult<[PR.PageResource.ParsedObject.Item]>.LoadPageBlock = { [weak self] completion in
                    self?.loadPagedResource(pagedResource, pageSize: pageSize, page: page, completion: completion)
                }
                completion(.error(error: err, retry: retry))
            }
        }
    }
}
