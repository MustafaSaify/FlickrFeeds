//
//  Bundle+Convenience.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 13/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation

extension Bundle {
    
    func apiBaseUrl() -> String {
        return infoValueForKey("MY_API_BASE_URL_ENDPOINT")!
    }
    
    func apiKey() -> String {
        return infoValueForKey("MY_API_KEY")!
    }
    
    func infoValueForKey<Value>(_ key: String) -> Value? {
        return infoDictionary![key] as? Value
    }
}
