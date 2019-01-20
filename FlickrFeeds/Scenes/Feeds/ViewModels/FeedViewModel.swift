//
//  FeedViewModel.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

protocol FeedViewModel {
    var url: URL? { get set }
    var title: String? { get set }
    var image: UIImage? { get set }
}
