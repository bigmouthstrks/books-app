//
//  AppCoordinator.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    func start()
}

// MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol: Coordinator {}

// MARK: - AppCoordinator
final class AppCoordinator {
    var navigationController: UINavigationController
    
    private var mainTabBarCoordinator: MainTabBarCoordinator?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.navigationBar.setDefaultConfiguration()
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    func start() {
        let vc = SplashWireframe.createModule(with: self)
        navigationController.setViewControllers([vc], animated: true)
    }
}

// MARK: - SplashDelegate
extension AppCoordinator: SplashDelegate {
    func onboardingRequested() {
        let vc = OnboardingWireframe.createModule(with: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onMainTabBarRequested() {
        mainTabBarCoordinator = nil
        
        let tbc = MainTabBarWireframe.createModule()
        
        mainTabBarCoordinator = MainTabBarCoordinator(tabBarController: tbc)
        mainTabBarCoordinator?.start()

        navigationController.setViewControllers([tbc], animated: true)
    }
}

// MARK: - OnboardingDelegate
extension AppCoordinator: OnboardingDelegate {
    func goToMainTabBar() {
        mainTabBarCoordinator = nil
        
        let tbc = MainTabBarWireframe.createModule()
        
        mainTabBarCoordinator = MainTabBarCoordinator(tabBarController: tbc)
        mainTabBarCoordinator?.start()

        navigationController.setViewControllers([tbc], animated: true)
    }
}
