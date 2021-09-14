//
//  EditProfileFieldWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 09-09-21.
//  
//

import UIKit

// MARK: - EditProfileFieldDelegate
protocol EditProfileFieldDelegate: AnyObject {
    func dismiss()
}

// MARK: - EditProfileFieldWireframe
enum EditProfileFieldWireframe {
    static func createModule(with delegate: EditProfileFieldDelegate, and fieldToUpdate: FieldType) -> UIViewController {
        let firebaseAuthManager = FirebaseAuthRemoteManager()
        
        let view = EditProfileFieldViewController.storyboardViewController()
        let presenter = EditProfileFieldPresenter()
        let interactor = EditProfileFieldInteractor(firebaseAuthManager: firebaseAuthManager)

        firebaseAuthManager.updateUserOutput = interactor
        
        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
        
        presenter.fieldType = fieldToUpdate
                
        return view
    }
}
