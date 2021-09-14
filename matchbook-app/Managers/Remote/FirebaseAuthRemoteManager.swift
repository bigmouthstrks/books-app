//
//  FirebaseAuthRemoteManager.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//

import FirebaseAuth
import FirebaseCore

// MARK: - FirebaseAuthRemoteManagerProtocol
protocol FirebaseAuthRemoteManagerProtocol: AnyObject {
    func getCurrentUser()
    func createUser(with userData: User, and password: String)
    func signIn(with email: String, and password: String)
    func resetPassword(for email: String)
    func isUserLoggedIn() -> Bool
    func logout()
    func updateEmail(to email: String)
    func updatePassword(to password: String)
    func updateImage(to imageURL: URL?)
    func getCurrentFirUser() -> FirebaseAuth.User?
}

// MARK: - SignInOutputProtocol
protocol SignInOutputProtocol: AnyObject {
    func onSignInSuccess()
    func onSignInFailed(with message: String)
}

// MARK: - CreateAccountOutputProtocol
protocol CreateAccountOutputProtocol: AnyObject {
    func onCreateUserSuccess(user: User)
    func onCreateUserFailed(message: String)
}

// MARK: - ResetPasswordOutputProtocol
protocol ResetPasswordOutputProtocol: AnyObject {
    func onResetPasswordSuccess(with message: String)
    func onResetPasswordFailed(with message: String)
}

// MARK: - LogoutOutputProtocol
protocol LogoutOutputProtocol: AnyObject {
    func onLogoutSuccess()
    func onLogoutFailed()
}

// MARK: - GetUserOutputProtocol
protocol GetUserOutputProtocol: AnyObject {
    func onGetUserSuccess(with user: FirebaseAuth.User?)
}

// MARK: - UpdateUserOutputProtocol
protocol UpdateUserOutputProtocol: AnyObject {
    func onUpdateUserSuccess(with message: String)
    func onUpdateUserFailed(with message: String)
}

// MARK: - FirebaseAuthRemoteManager
final class FirebaseAuthRemoteManager {
    weak var signInOutput: SignInOutputProtocol?
    weak var createAccountOutput: CreateAccountOutputProtocol?
    weak var logoutOutput: LogoutOutputProtocol?
    weak var resetPasswordOutput: ResetPasswordOutputProtocol?
    weak var getUserOutput: GetUserOutputProtocol?
    weak var updateUserOutput: UpdateUserOutputProtocol?
}

// MARK: - FirebaseAuthRemoteManager
extension FirebaseAuthRemoteManager: FirebaseAuthRemoteManagerProtocol {
    func getCurrentFirUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
    
    func getCurrentUser() {
        self.getUserOutput?.onGetUserSuccess(with: Auth.auth().currentUser)
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            logoutOutput?.onLogoutSuccess()
        } catch {
            print("Sign out error")
            logoutOutput?.onLogoutFailed()
        }
    }
    
    func createUser(with userData: User, and password: String) {
        Auth.auth().createUser(withEmail: userData.email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed: self.createAccountOutput?.onCreateUserFailed(message: "Operación no permita.")
                case .emailAlreadyInUse: self.createAccountOutput?.onCreateUserFailed(message: "El email ingresado ya se encuentra en uso.")
                case .invalidEmail: self.createAccountOutput?.onCreateUserFailed(message: "El email ingresado es inválido.")
                case .weakPassword: self.createAccountOutput?.onCreateUserFailed(message: "La contraseña ingresada es muy débil.")
                default: print("Error: \(error.localizedDescription)")
                }
            } else {
                let user = Auth.auth().currentUser
                    if let user = user {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = "\(userData.firstName) \(userData.lastName)"
                        changeRequest.photoURL = URL(string: "https://images.unsplash.com/photo-1517849845537-4d257902454a")
                        changeRequest.commitChanges { error in
                        if let error = error {
                            self.createAccountOutput?.onCreateUserFailed(message: "Su perfil no pudo ser actualizado.")
                        }
                    }
                }
                
                guard let result = authResult else { return }
                userData.id = result.user.uid
                userData.profileImage = "https://images.unsplash.com/photo-1517849845537-4d257902454a"
                self.createAccountOutput?.onCreateUserSuccess(user: userData)
            }
        }
    }
    
    func signIn(with email: String, and password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed: self.signInOutput?.onSignInFailed(with: "Operación no permitida.")
                case .userDisabled: self.signInOutput?.onSignInFailed(with: "Usuario deshabilitado.")
                case .wrongPassword: self.signInOutput?.onSignInFailed(with: "Contraseña incorrecta.")
                case .invalidEmail: self.signInOutput?.onSignInFailed(with: "Correo Electrónico inválido.")
                default:
                    print("Error: \(error.localizedDescription)")
                    self.signInOutput?.onSignInFailed(with: "Error al iniciar sesión.")
                }
            } else {
                self.signInOutput?.onSignInSuccess()
            }
        }
    }
    
    func resetPassword(for email: String) {
        Auth.auth().languageCode = "es"
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                case .userNotFound: self.resetPasswordOutput?.onResetPasswordFailed(with: "Usuario no existe.")
                case .invalidEmail: self.resetPasswordOutput?.onResetPasswordFailed(with: "Correo inválido.")
                case .invalidRecipientEmail: self.resetPasswordOutput?.onResetPasswordFailed(with: "Correo inválido.")
                case .invalidSender: self.resetPasswordOutput?.onResetPasswordFailed(with: "No se pudo restaurar la contraseña.")
                case .invalidMessagePayload: self.resetPasswordOutput?.onResetPasswordFailed(with: "No se pudo restaurar la contraseña.")
                default:
                    print("Error message: \(error.localizedDescription)")
                    self.resetPasswordOutput?.onResetPasswordFailed(with: "No se pudo restaurar la contraseña.")
                }
            } else {
                print("Reset password email has been successfully sent")
                self.resetPasswordOutput?.onResetPasswordSuccess(with: "Correo de restauración enviado con éxito.")
          }
        }
    }
    
    func updateEmail(to email: String) {
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if let error = error {
                print("error: ", error)
                self.updateUserOutput?.onUpdateUserFailed(with: "No se pudo actualizar su e-mail.")
            } else {
                self.updateUserOutput?.onUpdateUserSuccess(with: "Su e-mail ha sido actualizado con éxito")
            }
        }
    }
    
    func updatePassword(to password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if let error = error {
                print("error: ", error)
                self.updateUserOutput?.onUpdateUserFailed(with: "No se pudo actualizar su contraseña.")
            } else {
                self.updateUserOutput?.onUpdateUserSuccess(with: "Su contraseña ha sido actualizada con éxito")
            }
        }
    }
    
    func updateImage(to imageURL: URL?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = imageURL
        changeRequest?.commitChanges(completion: { error in
            if let error = error {
                print("ERROR POS")
            } else {
                print("TODO GUD")
            }
        })
    }
}
