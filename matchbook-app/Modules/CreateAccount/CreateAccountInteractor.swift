//
//  CreateAccountInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 20-08-21.
//  
//

import FirebaseAuth

// MARK: - CreateAccountInteractor
final class CreateAccountInteractor {
    required init(firebaseRemoteManager: FirebaseAuthRemoteManagerProtocol,
                  userLocalManager: UserDataManagerProtocol) {
        self.firebaseRemoteManager = firebaseRemoteManager
        self.userLocalManager = userLocalManager
    }
    
    var firebaseRemoteManager: FirebaseAuthRemoteManagerProtocol
    var userLocalManager: UserDataManagerProtocol
    weak var interactorOutput: CreateAccountInteractorOutputProtocol?
}

// MARK: - CreateAccountInteractorProtocol
extension CreateAccountInteractor: CreateAccountInteractorProtocol {
    func onCreateAccount(email: String, password: String, firstName: String, lastName: String) {
        let userData = User()
        userData.email = email
        userData.firstName = firstName
        userData.lastName = lastName
        firebaseRemoteManager.createUser(with: userData, and: password)
    }
}

// FIREBASE AUTH PROTOCOLS
// MARK: - CreateAccountOutput
extension CreateAccountInteractor: CreateAccountOutputProtocol {
    func onCreateUserSuccess(user: User) {
        userLocalManager.add(user: user, completion: {
            self.interactorOutput?.onCreateUserSuccess()
        })
    }
    
    func onCreateUserFailed(message: String) {
        interactorOutput?.onCreateUserFailed(message: message)
    }
}
