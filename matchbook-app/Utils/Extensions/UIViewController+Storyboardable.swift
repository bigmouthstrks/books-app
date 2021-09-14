//
//  UIViewController+Storyboardable.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//

import UIKit

// MARK: - Storyboardable
protocol Storyboardable: AnyObject {
    static var defaultStoryboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var defaultStoryboardName: String {
        let selfName = String(describing: self)
        return selfName.replacingOccurrences(of: "ViewController", with: "")
    }
    
    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return vc
    }
}

extension UIViewController: Storyboardable {}
