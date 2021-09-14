//
//  CreateAccountWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 20-08-21.
//  
//

import UIKit

// MARK: - CreateAccountDelegate
protocol CreateAccountDelegate: AnyObject {
    func goToLoginScreen()
}

// MARK: - CreateAccountWireframe
enum CreateAccountWireframe {
    static func createModule(with delegate: CreateAccountDelegate) -> UIViewController {
        let firebaseAuthRemoteManager = FirebaseAuthRemoteManager()
        let userLocalManager = UserDataManager()
        
        let view = CreateAccountViewController.storyboardViewController()
        let presenter = CreateAccountPresenter()
        let interactor = CreateAccountInteractor(firebaseRemoteManager: firebaseAuthRemoteManager,
                                                 userLocalManager: userLocalManager)

        firebaseAuthRemoteManager.createAccountOutput = interactor
        
        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
