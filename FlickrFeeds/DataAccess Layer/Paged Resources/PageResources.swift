//
//  PageResources.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 10/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

protocol PagedResponse {
    associatedtype Item
    var items: [Item] { get set }
    var totalPages: Int { get set }
}

protocol PageResources where PageResource: Resource, PageResource.ParsedObject: PagedResponse {
    
    associatedtype PageResource
    
    func resourceForPage(_ page: Int, pageSize: Int) -> PageResource
    
    func isLastPage(_ totalPages: Int, current: Int) -> Bool
}
