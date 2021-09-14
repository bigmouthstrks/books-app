//
//  UIColors+AppColors.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//

import UIKit

// MARK: - AppColors
extension UIColor {
    // Cold Neutral
    static var coldNeutral1: UIColor { UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.00) }
    static var coldNeutral2: UIColor { UIColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.00) }
    
    // Primary Light and Dark
    static var primary: UIColor { UIColor(red: 0.12, green: 0.68, blue: 1.00, alpha: 1.00) }
    static var primaryLight: UIColor { UIColor(red: 0.56, green: 0.84, blue: 1.00, alpha: 1.00) }
    static var primaryDark: UIColor { UIColor(red: 0.06, green: 0.34, blue: 0.50, alpha: 1.00) }
    static var primaryOpaque: UIColor { UIColor(red: 0.06, green: 0.34, blue: 0.50, alpha: 1.00) }
    
    // Secondary
    static var secondary: UIColor { UIColor(red: 1.00, green: 0.33, blue: 0.02, alpha: 1.00) }
    
    // Success
    static var success: UIColor { UIColor(red: 0.04, green: 0.94, blue: 0.02, alpha: 1.00) }
    
    // Warning
    static var warning: UIColor { UIColor(red: 0.98, green: 0.82, blue: 0.00, alpha: 1.00) }
    
    // Error
    static var error: UIColor { UIColor(red: 0.82, green: 0.01, blue: 0.45, alpha: 1.00) }
    
    // Background
    static var backgroundLight: UIColor { UIColor(red: 0.98, green: 0.99, blue: 1.00, alpha: 1.00) }
    
    // Toast View
    static var toastView: UIColor { UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 0.95) }
}
