//
//  CreateAccountProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 20-08-21.
//  
//

import Foundation

// MARK: - View
protocol CreateAccountViewProtocol: ActivityIndicatorable, NavigationBarVisibilityTogglable, ToastViewable {}

// MARK: - Interactor
protocol CreateAccountInteractorProtocol: AnyObject {
    func onCreateAccount(email: String, password: String, firstName: String, lastName: String)
}

// MARK: - InteractorOutput
protocol CreateAccountInteractorOutputProtocol: AnyObject {
    func onCreateUserFailed(message: String)
    func onCreateUserSuccess()
}

// MARK: - Presenter
protocol CreateAccountPresenterProtocol: Viewlifecycleable {
    func onCreateAccount(email: String?, password: String?, firstName: String?, lastName: String?)
}
