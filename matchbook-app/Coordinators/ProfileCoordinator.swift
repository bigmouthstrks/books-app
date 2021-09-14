//
//  ProfileCoordinator.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//

import UIKit

// MARK: - ProfileCoordinatorProtocol
protocol ProfileCoordinatorProtocol: Coordinator {}

// MARK: - ProfileCoordinator
final class ProfileCoordinator {
    let navigationController: UINavigationController

    internal init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.setDefaultConfiguration()
    }
}

// MARK: - ProfileDelegate
extension ProfileCoordinator: ProfileDelegate {
    func onAddBookRequested() {
        let newBookViewController = NewBookWireframe.createModule(with: self)
        newBookViewController.isModalInPresentation = true
        navigationController.present(newBookViewController, animated: true)
    }
    
    func onEditUserProfile() {
        let editProfileViewController = EditProfileWireframe.createModule(with: self)
        editProfileViewController.isModalInPresentation = true
        navigationController.present(editProfileViewController, animated: true)
    }
    
    func onLogoutPerformed() {
        let loginViewController = LoginWireframe.createModule(with: self)
        navigationController.setViewControllers([loginViewController], animated: true)
    }
}

// MARK: - ProfileCoordinatorProtocol
extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func start() {
        let firebaseRemoteManager = FirebaseAuthRemoteManager()
        
        var initialViewController: UIViewController {
            if firebaseRemoteManager.isUserLoggedIn() {
                return ProfileWireframe.createModule(with: self)
            } else {
                return LoginWireframe.createModule(with: self)
            }
        }
        
        navigationController.pushViewController(initialViewController, animated: true)
    }
}

// MARK: - LoginDelegate
extension ProfileCoordinator: LoginDelegate {
    func onGoToCreateAccount() {
        let vc = CreateAccountWireframe.createModule(with: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onPerformLogin() {
        let vc = ProfileWireframe.createModule(with: self)
        navigationController.setViewControllers([vc], animated: true)
    }
}

// MARK: - CreateAccountDelegate
extension ProfileCoordinator: CreateAccountDelegate {
    func goToLoginScreen() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - EditProfileDelegate
extension ProfileCoordinator: EditProfileDelegate {
    func onUpdatePasswordRequested() {
        let vc = EditProfileFieldWireframe.createModule(with: self, and: .updatePassword)
        
        navigationController.dismiss(animated: false, completion: {
            self.navigationController.pushViewController(vc, animated: true)
        })
    }
    
    func onUpdateEmailRequested() {
        let vc = EditProfileFieldWireframe.createModule(with: self, and: .updateEmail)
        
        navigationController.dismiss(animated: false, completion: {
            self.navigationController.pushViewController(vc, animated: true)
        })
    }
    
    func onDismissRequested() {
        navigationController.dismiss(animated: true)
    }
}

// MARK: - NewBookDelegate
extension ProfileCoordinator: NewBookDelegate {
    func onPresentImageSelectionRequested() {
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

// MARK: - EditProfileFieldDelegate
extension ProfileCoordinator: EditProfileFieldDelegate {}
