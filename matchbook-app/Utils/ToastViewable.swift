//
//  ToastViewable.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 31-08-21.
//

import UIKit

// MARK: - ToastViewable
protocol ToastViewable: AnyObject {
    func presentToastView(with message: String)
}

// MARK: - ToastViewable
extension ToastViewable where Self: UIViewController {
    func presentToastView(with message: String) {
        let toastView = UILabel()
        
        toastView.center = view.center
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.tintColor = .coldNeutral1
        toastView.textColor = .coldNeutral1
        toastView.textAlignment = .center
        toastView.sizeToFit()
        toastView.clipsToBounds = true
        toastView.frame = CGRect(x: self.view.frame.size.width/2 - 250/2, y: self.view.frame.size.height/2 - 70/2, width: 250, height: 70)
        toastView.backgroundColor = .toastView
        toastView.layer.cornerRadius = .defaultCornerRadius
        self.view.addSubview(toastView)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
}
