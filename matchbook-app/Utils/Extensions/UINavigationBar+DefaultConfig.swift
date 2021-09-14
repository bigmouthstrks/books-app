//
//  UINavigationBar.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//

import UIKit

// Default Navigation Bar Configuration
extension UINavigationBar {
    func setDefaultConfiguration() {
        self.barTintColor = .backgroundLight
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        self.isTranslucent = false
        self.backItem?.backButtonTitle = "Volver"
        self.tintColor = .primaryDark
    }
}
