//
//  UIViewController+MainTabBar.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//

import UIKit

// MARK: - MainTabBarController
extension UIViewController {
    // MARK: - Tab Bar
    var mainTabBarController: MainTabBarViewController? {
        return closestParentViewController(class: MainTabBarViewController.self) as? MainTabBarViewController
    }
    
    func closestParentViewController(class someClass: AnyClass) -> UIViewController? {
        var viewController: UIViewController? = self
        
        while let someViewController = viewController {
            if someViewController.isKind(of: someClass) { return someViewController }
            viewController = someViewController.parent
        }
        return nil
    }
}
