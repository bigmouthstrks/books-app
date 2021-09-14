//
//  EditProfileProtocols.swift
//  matchbook-app-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import UIKit

// MARK: - View
protocol EditProfileViewProtocol: ToastViewable, ActivityIndicatorable {}

// MARK: - Interactor
protocol EditProfileInteractorProtocol: AnyObject {
    func onSaveUserProfileChanges()
    func onUserDataRequested()
}

// MARK: - InteractorOutput
protocol EditProfileInteractorOutputProtocol: AnyObject {
    func onGetCurrentUserData(email: String?)
}

// MARK: - Presenter
protocol EditProfilePresenterProtocol: Viewlifecycleable {
    func onCancelButtonPressed()
    func onUpdatePasswordButtonPressed()
    func onUpdateEmailButtonPressed()
}
