//
//  EditProfileFieldPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 09-09-21.
//  
//

// MARK: - EditProfileFieldPresenter
final class EditProfileFieldPresenter {
    weak var view: EditProfileFieldViewProtocol?
    var interactor: EditProfileFieldInteractorProtocol?
    weak var delegate: EditProfileFieldDelegate?
    
    var fieldType: FieldType?
}

// MARK: - EditProfileFieldPresenterProtocol
extension EditProfileFieldPresenter: EditProfileFieldPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    
    func onViewWillAppear() {
        view?.showNavigationBar(animated: true)
        switch fieldType {
        case .updateEmail:
            view?.hidePasswordStackView()
        case .updatePassword:
            view?.hideEmailStackView()
        default: break
        }
    }

    // MARK: - View events
    func onUpdateEmailButtonPressed(newEmail: String?, confirmEmail: String?) {
        view?.startActivityIndicator()
        guard
            let email = newEmail, !email.isEmpty, confirmEmail == email,
            let confirmEmail = confirmEmail, !confirmEmail.isEmpty
        else {
            view?.stopActivityIndicator()
            view?.presentToastView(with: "Los correos no coinciden.")
            return
        }
        interactor?.updateUserEmail(with: email)
    }
    
    func onUpdatePasswordButtonPressed(newPassword: String?, confirmPassword: String?) {
        view?.startActivityIndicator()
        guard
            let password = newPassword, !password.isEmpty, confirmPassword == password,
            let confirmPassword = confirmPassword, !confirmPassword.isEmpty
        else {
            view?.stopActivityIndicator()
            view?.presentToastView(with: "Las contraseñas no coinciden.")
            return
        }
        interactor?.updateUserPassword(with: password)
    }
}

// MARK: - EditProfileFieldInteractorOutputProtocol
extension EditProfileFieldPresenter: EditProfileFieldInteractorOutputProtocol {
    func onUpdatedData(message: String) {
        view?.stopActivityIndicator()
        view?.presentToastView(with: message)
        delegate?.dismiss()
    }
    
    func onErrorUpdatingData(message: String) {
        view?.stopActivityIndicator()
        view?.presentToastView(with: message)
        delegate?.dismiss()
    }
}

// MARK: - fieldType
enum FieldType: String {
    case updatePassword
    case updateEmail
}
