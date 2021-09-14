//
//  ProfileWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import UIKit

// MARK: - ProfileDelegate
protocol ProfileDelegate: AnyObject {
    func onLogoutPerformed()
    func onEditUserProfile()
    func onAddBookRequested()
    
}

// MARK: - ProfileWireframe
enum ProfileWireframe {
    static func createModule(with delegate: ProfileDelegate) -> UIViewController {
        let firebaseRemoteManager = FirebaseAuthRemoteManager()
        let userDataManager = UserDataManager()
        let userBooksDataManager = UserBooksDataManager()
        let profileImageDataManager = ProfileImageDataManager()
        
        let view = ProfileViewController.storyboardViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(firebaseRemoteManager: firebaseRemoteManager,
                                           userDataManager: userDataManager,
                                           userBooksDataManager: userBooksDataManager,
                                           profileImageDataManager: profileImageDataManager)
        
        firebaseRemoteManager.logoutOutput = interactor

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
