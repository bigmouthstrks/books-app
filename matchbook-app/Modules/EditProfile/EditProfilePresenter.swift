//
//  EditProfilePresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

// MARK: - EditProfilePresenter
final class EditProfilePresenter {
    weak var view: EditProfileViewProtocol?
    var interactor: EditProfileInteractorProtocol?
    weak var delegate: EditProfileDelegate?
}

// MARK: - EditProfilePresenterProtocol
extension EditProfilePresenter: EditProfilePresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    func onViewWillAppear() {
        interactor?.onUserDataRequested()
    }

    // MARK: - View events
    func onCancelButtonPressed() {
        delegate?.onDismissRequested()
    }
    
    func onUpdatePasswordButtonPressed() {
        delegate?.onUpdatePasswordRequested()
    }
    
    func onUpdateEmailButtonPressed() {
        delegate?.onUpdateEmailRequested()
    }
}

// MARK: - EditProfileInteractorOutputProtocol
extension EditProfilePresenter: EditProfileInteractorOutputProtocol {
    func onGetCurrentUserData(email: String?) {}
}
