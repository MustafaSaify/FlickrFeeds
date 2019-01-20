//
//  UIViewController+Containment.swift
//  FlickrFeeds
//
//  Created by Mustafa Saify on 11/01/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func addImmediatelyChildViewController(_ childController: UIViewController, embeddedInView container: UIView, belowSubview: UIView? = nil) {
        addChild(childController)
        container.embedSubview(childController.view, belowView:belowSubview)
        childController.didMove(toParent: self)
    }
    
    func removeImmediatelyFromParentViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}


extension UIView {
    
    func embedSubview(_ view: UIView, belowView: UIView? = nil) {
        if let topView = belowView {
            insertSubview(view, belowSubview: topView)
        }
        else {
            addSubview(view)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraintsForItem(view, withEqualFrameAsItem: self)
    }
}


extension NSLayoutConstraint {
    
    static func activateConstraintsForItem(_ item: AnyObject, withEqualFrameAsItem secondItem: AnyObject) {
        activate(
            constraintsForItem(
                item,
                withEqualAttributes: [.left, .right, .top, .bottom],
                toItem: secondItem)
        )
    }
    
    static func constraintsForItem(_ item: AnyObject, withEqualAttributes attributes: [NSLayoutConstraint.Attribute], toItem: AnyObject) -> [NSLayoutConstraint] {
        return attributes.map {
            return NSLayoutConstraint(item: item, withEqualAttribute: $0, toItem: toItem)
        }
    }
    
    convenience init(item: AnyObject, withEqualAttribute attribute: NSLayoutConstraint.Attribute, toItem: AnyObject) {
        self.init(item: item, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: attribute, multiplier: 1, constant: 0)
    }
}
