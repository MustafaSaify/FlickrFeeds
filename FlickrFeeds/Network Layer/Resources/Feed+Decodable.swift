//
//  Feed+Decodable.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 10/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension Feed: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .owner)
        title = try container.decode(String.self, forKey: .title)
        server = try container.decode(String.self, forKey: .server)
        farm = try container.decode(Int.self, forKey: .farm)
        secret = try container.decode(String.self, forKey: .secret)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, owner, title, server, farm, secret
    }
}


