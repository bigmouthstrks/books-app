//
//  OnboardingWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 30-08-21.
//  
//

import UIKit

// MARK: - OnboardingDelegate
protocol OnboardingDelegate: AnyObject {
    func goToMainTabBar()
}

// MARK: - OnboardingWireframe
enum OnboardingWireframe {
    static func createModule(with delegate: OnboardingDelegate) -> UIViewController {
        let onboardingLocalManager = OnboardingLocalManager()
        
        let view = OnboardingViewController.storyboardViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor(onboardingLocalManager: onboardingLocalManager)

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
