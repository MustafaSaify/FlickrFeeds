//
//  FeedResource.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 09/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

struct FeedResponse: PagedResponse {
    var items: [Feed]
    var totalPages: Int
}

struct FeedResource {
    let baseURL: URL
    let searchText: String
    let page: Int?
    let pageSize: Int?
}

private extension FeedResource {
    
    var parameters: [String: AnyObject] {
        var param = [String: AnyObject]()
        param["text"] = searchText as AnyObject?
        param["page"] = page as AnyObject?
        param["per_page"] = pageSize as AnyObject?
        param["method"] = "flickr.photos.search" as AnyObject?
        param["api_key"] = Bundle.main.apiKey() as AnyObject?
        param["format"] = ResponseFormat.json.rawValue as AnyObject?
        param["nojsoncallback"] = true as AnyObject?
        param["safe_search"] = 1 as AnyObject?
        return param
    }
}

extension FeedResource: Resource {
    
    func request() -> URLRequest {
        return URLRequest(baseURL: baseURL,
                          path: "/",
                          parameters: parameters)!
    }
    
    var parse: (Data) throws -> FeedResponse {
        return { data in
            let components =  try JSONDecoder()
                                .decode(SearchFeedsRoot.self, from: data)
                                .components
            return FeedResponse(items: components.feeds,
                                totalPages: components.pages)
        }
    }
}

private struct SearchFeedsRoot: Decodable {
    let components: Photos
    
    enum CodingKeys: String, CodingKey {
        case components = "photos"
    }
}

private struct Photos: Decodable {
    let feeds: [Feed]
    let pages: Int
    
    enum CodingKeys: String, CodingKey {
        case feeds = "photo"
        case pages
    }
}
