//
//  SplashViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

import UIKit

// MARK: - SplashViewController
final class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol?
}

// MARK: - Lifecycle
extension SplashViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.onViewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onViewWillAppear()
    }
}

// MARK: - SplashViewProtocol
extension SplashViewController: SplashViewProtocol {}
