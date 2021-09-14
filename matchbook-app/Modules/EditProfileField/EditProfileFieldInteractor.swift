//
//  EditProfileFieldInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 09-09-21.
//  
//

import Foundation

// MARK: - EditProfileFieldInteractor
final class EditProfileFieldInteractor {
    required init(firebaseAuthManager: FirebaseAuthRemoteManagerProtocol) {
        self.firebaseAuthManager = firebaseAuthManager
    }
    
    var firebaseAuthManager: FirebaseAuthRemoteManagerProtocol
    weak var interactorOutput: EditProfileFieldInteractorOutputProtocol?
}

// MARK: - EditProfileFieldInteractorProtocol
extension EditProfileFieldInteractor: EditProfileFieldInteractorProtocol {
    func updateUserEmail(with email: String) {
        firebaseAuthManager.updateEmail(to: email)
    }
    
    func updateUserPassword(with password: String) {
        firebaseAuthManager.updatePassword(to: password)
    }
    
    func updateUserImage(with imageURL: URL?) {
        firebaseAuthManager.updateImage(to: imageURL)
    }
}

// MARK: - UpdateUserOutputProtocol
extension EditProfileFieldInteractor: UpdateUserOutputProtocol {
    func onUpdateUserSuccess(with message: String) {
        interactorOutput?.onUpdatedData(message: message)
    }
    
    func onUpdateUserFailed(with message: String) {
        interactorOutput?.onErrorUpdatingData(message: message)
    }
}
