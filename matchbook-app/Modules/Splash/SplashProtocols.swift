//
//  SplashProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

import UIKit

// MARK: - View
protocol SplashViewProtocol: NavigationBarVisibilityTogglable {}

// MARK: - Interactor
protocol SplashInteractorProtocol: AnyObject {
    func checkOnboardingStatus()
}

// MARK: - InteractorOutput
protocol SplashInteractorOutputProtocol: AnyObject {
    func onboardingIsDone(status: Bool)
}

// MARK: - Presenter
protocol SplashPresenterProtocol: Viewlifecycleable {}
