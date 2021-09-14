//
//  OnboardingInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 30-08-21.
//  
//

// MARK: - OnboardingInteractor
final class OnboardingInteractor {
    required init(onboardingLocalManager: OnboardingLocalManager) {
        self.onboardingLocalManager = onboardingLocalManager
    }
    
    var onboardingLocalManager: OnboardingLocalManagerProtocol
    weak var interactorOutput: OnboardingInteractorOutputProtocol?
}

// MARK: - OnboardingInteractorProtocol
extension OnboardingInteractor: OnboardingInteractorProtocol {
    func setupFavorites() {}
    
    func onboardingFinished() {
        onboardingLocalManager.saveStatus(status: true)
    }
}
