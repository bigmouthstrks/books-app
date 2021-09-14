//
//  OnboardingLocalManager.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 30-08-21.
//

import Foundation

// MARK: - OnboardingLocalManagerProtocol
protocol OnboardingLocalManagerProtocol: AnyObject {
    func isDone() -> Bool
    func saveStatus(status: Bool)
}

// MARK: - OnboardingLocalManagerOutputProtocol
protocol OnboardingLocalManagerOutputProtocol: AnyObject {}

// MARK: - OnboardingLocalManager
final class OnboardingLocalManager {
    weak var managerOutput: OnboardingLocalManagerOutputProtocol?
}

// MARK: - OnboardingLocalManager
extension OnboardingLocalManager: OnboardingLocalManagerProtocol {
    func isDone() -> Bool {
        return UserDefaults.standard.bool(forKey: "_OnboardingStatus")
    }
    
    func saveStatus(status: Bool) {
        UserDefaults.standard.setValue(status, forKey: "_OnboardingStatus")
    }
}
