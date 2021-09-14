//
//  CreateAccountPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 20-08-21.
//  
//

// MARK: - CreateAccountPresenter
final class CreateAccountPresenter {
    weak var view: CreateAccountViewProtocol?
    var interactor: CreateAccountInteractorProtocol?
    weak var delegate: CreateAccountDelegate?
}

// MARK: - CreateAccountPresenterProtocol
extension CreateAccountPresenter: CreateAccountPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() { }
    func onViewWillAppear() { view?.showNavigationBar(animated: true) }

    // MARK: - View events
    func onCreateAccount(email: String?, password: String?, firstName: String?, lastName: String?) {
        view?.startActivityIndicator()
        guard
            let email = email , !email.isEmpty,
            let password = password , !password.isEmpty,
            let firstName = firstName , !firstName.isEmpty,
            let lastName = lastName , !lastName.isEmpty
        else {
            view?.stopActivityIndicator()
            view?.presentToastView(with: "Por favor verifique los datos ingresados.")
            return
        }
        interactor?.onCreateAccount(email: email, password: password, firstName: firstName, lastName: lastName)
    }
}

// MARK: - CreateAccountInteractorOutputProtocol
extension CreateAccountPresenter: CreateAccountInteractorOutputProtocol {
    func onCreateUserSuccess() {
        view?.stopActivityIndicator()
        view?.presentToastView(with: "¡Cuenta creada con éxito!")
        delegate?.goToLoginScreen()
    }
    
    func onCreateUserFailed(message: String) {
        view?.stopActivityIndicator()
        view?.presentToastView(with: message)
    }
}
