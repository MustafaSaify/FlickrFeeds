//
//  Feed.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct Feed {
    var id: String
    var author: String?
    var title: String?
    var server: String?
    var farm: Int
    var secret: String?
    
    var photoUrl: URL? {
        guard let server = self.server, let secret = self.secret else { return nil }
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")
    }
}
