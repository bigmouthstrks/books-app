//
//  SplashWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

import UIKit

// MARK: - SplashDelegate
protocol SplashDelegate: AnyObject {
    func onboardingRequested()
    func onMainTabBarRequested()
}

// MARK: - SplashWireframe
enum SplashWireframe {
    static func createModule(with delegate: SplashDelegate) -> UIViewController {
        let onboardingLocalManager = OnboardingLocalManager()
        
        let view = SplashViewController.storyboardViewController()
        let presenter = SplashPresenter()
        let interactor = SplashInteractor(onboardingLocalManager: onboardingLocalManager)

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
