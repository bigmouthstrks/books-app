//
//  LoginProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

import UIKit

// MARK: - View
protocol LoginViewProtocol: ActivityIndicatorable, NavigationBarVisibilityTogglable, ToastViewable {}

// MARK: - Interactor
protocol LoginInteractorProtocol: AnyObject {
    func onLogin(email: String, password: String)
    func onResetPassword(email: String)
}

// MARK: - InteractorOutput
protocol LoginInteractorOutputProtocol: AnyObject {
    func onLoginPerformed()
    func onLoginError(message: String)
    func onResetPasswordSuccess(message: String)
    func onResetPasswordFailed(message: String)
}

// MARK: - Presenter
protocol LoginPresenterProtocol: Viewlifecycleable {
    func onCreateAccount()
    func onLogin(email: String?, password: String?)
    func onResetPassword(email: String?)
}
