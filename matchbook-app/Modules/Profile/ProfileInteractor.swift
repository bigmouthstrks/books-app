//
//  ProfileInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import FirebaseAuth

// MARK: - ProfileInteractor
final class ProfileInteractor {
    required init(firebaseRemoteManager: FirebaseAuthRemoteManagerProtocol,
                  userDataManager: UserDataManagerProtocol,
                  userBooksDataManager: UserBooksDataManagerProtocol,
                  profileImageDataManager: ProfileImageDataManagerProtocol) {
        self.firebaseRemoteManager = firebaseRemoteManager
        self.userDataManager = userDataManager
        self.userBooksDataManager = userBooksDataManager
        self.profileImageDataManager = profileImageDataManager
    }
    
    weak var interactorOutput: ProfileInteractorOutputProtocol?
    let firebaseRemoteManager: FirebaseAuthRemoteManagerProtocol
    let userBooksDataManager: UserBooksDataManagerProtocol
    let userDataManager: UserDataManagerProtocol
    let profileImageDataManager: ProfileImageDataManagerProtocol
}

// MARK: - ProfileInteractorProtocol
extension ProfileInteractor: ProfileInteractorProtocol {
    func getMyBooks() {
        guard
            let currentUserId = firebaseRemoteManager.getCurrentFirUser()?.uid,
            let userBooks = userBooksDataManager.getUserBooks(id: currentUserId) else { return }
        interactorOutput?.onGetUserBooks(userBooks: userBooks)
    }
    
    func storeProfileImage(url: URL?) {
        firebaseRemoteManager.updateImage(to: url)
    }
    
    func getUserProfile() {
        guard let currentUser = userDataManager.getUser() else { return }
        interactorOutput?.onProfileFetched(with: currentUser)
    }
    
    func performLogout() {
        firebaseRemoteManager.logout()
    }
}

// MARK: - LogoutOutputProtocol
extension ProfileInteractor: LogoutOutputProtocol {
    func onLogoutSuccess() {
        interactorOutput?.logoutPerformed()
    }
    
    func onLogoutFailed() {}
}

// MARK: - GetUserOutputProtocol
extension ProfileInteractor: GetUserOutputProtocol {
    func onGetUserSuccess(with user: FirebaseAuth.User?) {}
}
