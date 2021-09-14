//
//  EditProfileFieldProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 09-09-21.
//  
//

import Foundation

// MARK: - View
protocol EditProfileFieldViewProtocol: ToastViewable, NavigationBarVisibilityTogglable, ActivityIndicatorable {
    func hideEmailStackView()
    func hidePasswordStackView()
}

// MARK: - Interactor
protocol EditProfileFieldInteractorProtocol: AnyObject {
    func updateUserEmail(with email: String)
    func updateUserPassword(with password: String)
    func updateUserImage(with imageURL: URL?)
}

// MARK: - InteractorOutput
protocol EditProfileFieldInteractorOutputProtocol: AnyObject {
    func onUpdatedData(message: String)
    func onErrorUpdatingData(message: String)
}

// MARK: - Presenter
protocol EditProfileFieldPresenterProtocol: Viewlifecycleable {
    func onUpdateEmailButtonPressed(newEmail: String?, confirmEmail: String?)
    func onUpdatePasswordButtonPressed(newPassword: String?, confirmPassword: String?)
}
