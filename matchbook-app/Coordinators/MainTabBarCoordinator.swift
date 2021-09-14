//
//  MainTabBarCoordinator.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//  Copyright © 2021 Benjamin Cáceres. All rights reserved.
//

import UIKit

// MARK: - MainTabBarCoordinatorProtocol
protocol MainTabBarCoordinatorProtocol: Coordinator {}

// MARK: - MainTabBarCoordinator
final class MainTabBarCoordinator {
    let tabBarController: UITabBarController
    
    private var profileCoordinator: ProfileCoordinator?
    private var booksCoordinator: BooksCoordinator?
    
    weak var delegate: MainTabBarDelegate?

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
}

// MARK: - MainTabBarCoordinatorProtocol
extension MainTabBarCoordinator: MainTabBarCoordinatorProtocol {
    func start() {
        let viewControllers = [UINavigationController(), UINavigationController(), UINavigationController()]

        booksCoordinator = BooksCoordinator(navigationController: viewControllers[0])
        booksCoordinator?.start()
        
        profileCoordinator = ProfileCoordinator(navigationController: viewControllers[1])
        profileCoordinator?.start()
        
        tabBarController.setViewControllers(viewControllers, animated: true)
    }
}

// MARK: - MainTabBarDelegate
extension MainTabBarCoordinator: MainTabBarDelegate {
    func onLogoutPerformed() {}
    func onLoginPerformed() {}
}
