//
//  SplashPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

// MARK: - SplashPresenter
final class SplashPresenter {
    weak var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    weak var delegate: SplashDelegate?
}

// MARK: - SplashPresenterProtocol
extension SplashPresenter: SplashPresenterProtocol {
    func onViewWillAppear() { view?.hideNavigationBar(animated: true) }
    func onViewDidAppear() { interactor?.checkOnboardingStatus() }
}

// MARK: - SplashInteractorOutputProtocol
extension SplashPresenter: SplashInteractorOutputProtocol {
    func onboardingIsDone(status: Bool) {
        switch status {
        case false: delegate?.onboardingRequested()
        case true: delegate?.onMainTabBarRequested()
        }
    }
}
