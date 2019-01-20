//
//  DaoTest.swift
//  FlickrFeedsTests
//
//  Created by Mustafa Saify on 20/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import XCTest
@testable import FlickrFeeds

class DaoTests: XCTestCase {
    
    let dao: DataAccess = NetworkDataAccess(
        baseURL: URL(string: Bundle.main.apiBaseUrl())!,
        cacheTime: 60
    )
    
    func testSingleQuery() {
        
        let expectation = self.expectation(description: "all items retrieved")
        
        dao.feedsWithQuery("k", pageSize: 10) { (feedResult) in
            if case .success = feedResult {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testQuietCancelation() {
        
        dao.feedsWithQuery("k", pageSize: 50) { (feedResult) in
            if case .error(let message) = feedResult {
                print(message)
                XCTFail("Cancellation should fail quietly")
            }
        }
        
        testSingleQuery()
    }
    
    func testCachePerformance() {
        
        func loadSingleQuery() {
            let expectation = self.expectation(description: "random request loaded")
            dao.feedsWithQuery("kittens", pageSize: 10) {result in
                if case .success = result {
                    expectation.fulfill()
                }
            }
            waitForExpectations(timeout: 60, handler: nil)
        }
        
        // first time run of a query should actualy connect with API
        loadSingleQuery()
        
        // second run should return with results from cache
        measure {
            loadSingleQuery()
        }
    }
}
