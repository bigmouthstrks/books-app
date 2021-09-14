//
//  SplashInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

// MARK: - SplashInteractor
final class SplashInteractor {
    required init(onboardingLocalManager: OnboardingLocalManager) {
        self.onboardingLocalManager = onboardingLocalManager
    }
    
    let onboardingLocalManager: OnboardingLocalManagerProtocol
    weak var interactorOutput: SplashInteractorOutputProtocol?
}

// MARK: - SplashInteractorProtocol
extension SplashInteractor: SplashInteractorProtocol {
    func checkOnboardingStatus() {
        if onboardingLocalManager.isDone() {
            interactorOutput?.onboardingIsDone(status: true)
        } else {
            interactorOutput?.onboardingIsDone(status: false)
        }
    }
}
