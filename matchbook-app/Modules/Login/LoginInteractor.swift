//
//  LoginInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

// MARK: - LoginInteractor
final class LoginInteractor {
    required init(firebaseRemoteManager: FirebaseAuthRemoteManager) {
        self.firebaseRemoteManager = firebaseRemoteManager
    }
    
    var firebaseRemoteManager: FirebaseAuthRemoteManagerProtocol
    weak var interactorOutput: LoginInteractorOutputProtocol?
}

// MARK: - LoginInteractorProtocol
extension LoginInteractor: LoginInteractorProtocol {
    func onLogin(email: String, password: String) {
        firebaseRemoteManager.signIn(with: email, and: password)
    }
    
    func onResetPassword(email: String) {
        firebaseRemoteManager.resetPassword(for: email)
    }
}

// FIREBASE AUTH PROTOCOLS
// MARK: - SignInOutputProtocol
extension  LoginInteractor: SignInOutputProtocol {
    func onSignInSuccess() {
        interactorOutput?.onLoginPerformed()
    }
    
    func onSignInFailed(with message: String) {
        interactorOutput?.onLoginError(message: message)
    }
}

// MARK: - ResetPasswordOutputProtocol
extension  LoginInteractor: ResetPasswordOutputProtocol {
    func onResetPasswordSuccess(with message: String) {
        interactorOutput?.onResetPasswordSuccess(message: message)
    }
    
    func onResetPasswordFailed(with message: String) {
        interactorOutput?.onResetPasswordFailed(message: message)
    }
}
