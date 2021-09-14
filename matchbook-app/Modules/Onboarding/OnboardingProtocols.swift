//
//  OnboardingProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 30-08-21.
//  
//

import UIKit

// MARK: - View
protocol OnboardingViewProtocol: AnyObject {}

// MARK: - Interactor
protocol OnboardingInteractorProtocol: AnyObject {
    func onboardingFinished()
    func setupFavorites()
}

// MARK: - InteractorOutput
protocol OnboardingInteractorOutputProtocol: AnyObject {}

// MARK: - Presenter
protocol OnboardingPresenterProtocol: Viewlifecycleable {
    func onContinueButtonPressed()
}
