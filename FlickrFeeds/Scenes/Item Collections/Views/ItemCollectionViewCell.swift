//
//  CollectionViewCell.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 11/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var prepareForReuseBlock: (() -> Void)?
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var bottomSubtitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet fileprivate weak var bottomStackView: UIStackView!
    
    override var isHighlighted: Bool {
        didSet {
            bottomView.backgroundColor = isHighlighted ? UIColor.myRedColor() : UIColor.myGreyColor()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseBlock?()
        prepareForReuseBlock = nil
    }
}
