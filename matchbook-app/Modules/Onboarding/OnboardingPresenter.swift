//
//  OnboardingPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 30-08-21.
//  
//

// MARK: - OnboardingPresenter
final class OnboardingPresenter {
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorProtocol?
    weak var delegate: OnboardingDelegate?
}

// MARK: - OnboardingPresenterProtocol
extension OnboardingPresenter: OnboardingPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    func onViewWillAppear() {}


    // MARK: - View events
    func onContinueButtonPressed() {
        interactor?.onboardingFinished()
        delegate?.goToMainTabBar()
        interactor?.setupFavorites()
    }
}

// MARK: - OnboardingInteractorOutputProtocol
extension OnboardingPresenter: OnboardingInteractorOutputProtocol {}
