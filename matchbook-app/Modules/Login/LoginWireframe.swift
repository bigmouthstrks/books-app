//
//  LoginWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

import UIKit

// MARK: - LoginDelegate
protocol LoginDelegate: AnyObject {
    func onGoToCreateAccount()
    func onPerformLogin()
}

// MARK: - LoginWireframe
enum LoginWireframe {
    static func createModule(with delegate: LoginDelegate) -> UIViewController {
        let firebaseRemoteManager = FirebaseAuthRemoteManager()
        
        let view = LoginViewController.storyboardViewController()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(firebaseRemoteManager: firebaseRemoteManager)
        
        firebaseRemoteManager.signInOutput = interactor
        firebaseRemoteManager.resetPasswordOutput = interactor

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
