//
//  LoadFeedStateMachine.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 10/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

enum LoadingFeedState<Page> {
    case idle
    case loading(initial: Bool)
    case succeed(page: Page, lastPage: Bool)
    case failed(error: Error)
    case ended
}


class LoadingFeedStateMachine<Page> {
    
    fileprivate(set) var state: LoadingFeedState<Page> = .idle {
        didSet { stateDidChange(state) }
    }
    
    init(stateDidChange: @escaping (LoadingFeedState<Page>) -> Void) {
        self.stateDidChange = stateDidChange
    }
    
    func startFeed(_ load: FeedResult<Page>.LoadPageBlock) {
        state = .loading(initial: true)
        load(handleFeedResult)
    }
    
    func next() {
        guard let loadNext = loadNext else {
            return
        }
        state = .loading(initial: false)
        loadNext(handleFeedResult)
        self.loadNext = nil
    }
    
    fileprivate var loadNext: FeedResult<Page>.LoadPageBlock?
    fileprivate let stateDidChange: (LoadingFeedState<Page>) -> Void
    
    fileprivate func handleFeedResult(_ result: FeedResult<Page>) {
        switch result {
        case .success(let page, let nextPage):
            loadNext = nextPage
            state = .succeed(page: page, lastPage: loadNext == nil)
        case .error(let message, let retry):
            loadNext = retry
            state = .failed(error: message)
        case .feedEnd:
            loadNext = nil
            state = .ended
        }
    }
}
