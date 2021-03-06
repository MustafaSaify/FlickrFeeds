//
//  CollectionRegistrationState.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 11/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

typealias RegisterBlock = (_ collectionView: UICollectionView, _ aClass: AnyClass) -> String // returns registered identifier

/**
 Helper enum to be used to register cell just once and than use it's identifier to dequeue from collection view.
 */
enum CollectionRegistrationState {
    case notRegistered(RegisterBlock)
    case registered(identifier: String)
    
    init(resiterBlock: @escaping RegisterBlock) {
        self = .notRegistered(resiterBlock)
    }
    
    mutating func reuseIdentifierForClass(_ cellClass: AnyClass, inCollectionView collectionView: UICollectionView) -> String {
        switch self {
        case .notRegistered(let register):
            let identifier = register(collectionView, cellClass)
            self = .registered(identifier: identifier)
            return identifier
        case .registered(let identifier):
            return identifier
        }
    }
}
