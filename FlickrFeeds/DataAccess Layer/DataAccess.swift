//
//  DataAccess.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 11/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol DataAccess {
    
    func feedsWithQuery(_ q: String, pageSize: Int, completion: @escaping (FeedResult<[Feed]>) -> Void)
}
