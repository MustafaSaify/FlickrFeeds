//
//  AppDelegate.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 10/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = itemsViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

private let oneHour: TimeInterval = 60 * 60

private extension AppDelegate {
    
    func itemsViewController() -> UIViewController {
        let baseURL = URL(string: Bundle.main.apiBaseUrl())!
        let dataAccess = NetworkDataAccess(baseURL: baseURL, cacheTime: oneHour)
        let imageAccess = NetworkImageAccess(cacheTime: 24 * oneHour)
        return SearchFeedsViewController(dataAccess: dataAccess, imageAccess: imageAccess)
    }
}

