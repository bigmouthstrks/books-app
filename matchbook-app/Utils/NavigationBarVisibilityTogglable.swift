//
//  NavigationBarVisibilityTogglable.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 31-08-21.
//

import UIKit

// MARK: - NavigationBarVisibilityTogglable
protocol NavigationBarVisibilityTogglable: AnyObject {
    func showNavigationBar(animated: Bool)
    func hideNavigationBar(animated: Bool)
}

// MARK: - Default implementation
extension NavigationBarVisibilityTogglable where Self: UIViewController {
    func showNavigationBar(animated: Bool = true) {
        guard let nc = navigationController, nc.isNavigationBarHidden else { return }
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setDefaultConfiguration()
    }

    func hideNavigationBar(animated: Bool = true) {
        guard let nc = navigationController, !nc.isNavigationBarHidden else { return }
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.setDefaultConfiguration()
    }
}
