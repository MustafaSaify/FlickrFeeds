//
//  ItemCollectionBottomReusableView+LoadingFeedState.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension ItemsCollectionBottomReusableView {
    
    func updateWithLoadingState<T>(_ loadingState: LoadingFeedState<T>) {
        switch loadingState {
        case .succeed(_, lastPage: true):
            state = .theEnd
        case .idle, .succeed:
            state = .idle
        case .loading:
            state = .inProgress
        case .failed(let error):
            switch error {
            case SynchronizerError.wrongStatusError(403):
                state = .tryAgain(message: "Something went wrong.")
            case SynchronizerError.urlSessionError(let other):
                state = .tryAgain(message: other.localizedDescription)
            default:
                state = .tryAgain(message: "Something went wrong.")
            }
        case .ended:
            state = .theEnd
        }
    }
}
