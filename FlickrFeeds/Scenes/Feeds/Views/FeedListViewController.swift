//
//  FeedListViewController.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class FeedListViewController: ItemsCollectionViewController<Feed> {
    
    let imageAccess: ImageAccess
    
    init(imageAccess: ImageAccess) {
        self.imageAccess = imageAccess
        super.init(
            configureCell: { cell, feed in
                cell.configureWithFeed(feed, imageAccess: imageAccess)
                
        },
            estimatedCellHeight: ItemCollectionViewCell.estimatedHeight(),
            preferredCellHeight: ItemCollectionViewCell.preferredHeightWithFeed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ItemCollectionViewCell {
    
    func configureWithFeed(_ feed: Feed, imageAccess: ImageAccess) {
        bottomSubtitle.text = feed.author ?? ""
        bottomTitle.text = feed.title
        
        let cancelImageLoading = feed.photoUrl != nil ? imageAccess.imageWithURL(feed.photoUrl!) { [weak self] (image) in
            self?.imageView.image = image
            } : nil
        prepareForReuseBlock = { [weak self] in
            self?.imageView.image = nil
            cancelImageLoading?()
        }
    }
    
    static func preferredHeightWithFeed(_ feed: Feed) -> CGFloat {
        return 300 + 64
    }
    
    static func estimatedHeight() -> CGFloat {
        // roughly looking at handful of Item objects I guess an avarage size attribute at 30
        return 300 + 64
    }
}
