//
//  EditProfileInteractor.swift
//  matchbook-app-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

// MARK: - EditProfileInteractor
final class EditProfileInteractor {
    required init() {}
    
    weak var interactorOutput: EditProfileInteractorOutputProtocol?
}

// MARK: - EditProfileInteractorProtocol
extension EditProfileInteractor: EditProfileInteractorProtocol {
    func onUserDataRequested() {}
    
    func onSaveUserProfileChanges() {}
}

