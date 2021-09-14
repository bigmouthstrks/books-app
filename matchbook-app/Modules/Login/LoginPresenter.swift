//
//  LoginPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

// MARK: - LoginPresenter
final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    weak var delegate: LoginDelegate?
}

// MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    func onViewWillAppear() { view?.hideNavigationBar(animated: true) }


    // MARK: - View events
    func onCreateAccount() {
        delegate?.onGoToCreateAccount()
    }
    
    func onLogin(email: String?, password: String?) {
        view?.startActivityIndicator()
        guard
            let email = email, !email.isEmpty,
            let password = password, !password.isEmpty
        else {
            view?.stopActivityIndicator()
            view?.presentToastView(with: "Por favor verifique sus credenciales.")
            return
        }
        interactor?.onLogin(email: email, password: password)
    }
    
    func onResetPassword(email: String?) {
        view?.startActivityIndicator()
        guard let email = email, !email.isEmpty else {
            view?.stopActivityIndicator()
            view?.presentToastView(with: "Por favor verifique el correo ingresado.")
            return
        }
        interactor?.onResetPassword(email: email)
    }
}

// MARK: - LoginInteractorOutputProtocol
extension LoginPresenter: LoginInteractorOutputProtocol {
    func onLoginPerformed() {
        view?.stopActivityIndicator()
        delegate?.onPerformLogin()
    }
    
    func onLoginError(message: String) {
        view?.stopActivityIndicator()
        view?.presentToastView(with: message)
    }
    
    func onResetPasswordSuccess(message: String) {
        view?.stopActivityIndicator()
        view?.presentToastView(with: message)
    }
    
    func onResetPasswordFailed(message: String) {
        view?.stopActivityIndicator()
        view?.presentToastView(with: message)
    }
}
