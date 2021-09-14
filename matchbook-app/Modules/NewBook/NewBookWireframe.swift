//
//  NewBookWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import UIKit

// MARK: - NewBookDelegate
protocol NewBookDelegate: AnyObject {
    func onDismissRequested()
    func onPresentImageSelectionRequested()
}

// MARK: - NewBookWireframe
enum NewBookWireframe {
    static func createModule(with delegate: NewBookDelegate) -> UIViewController {
        let bookDataManager = BookDataManager()
        let userBooksDataManager = UserBooksDataManager()
        let userDataManager = UserDataManager()
        let firebaseAuthManager = FirebaseAuthRemoteManager()
        
        let view = NewBookViewController.storyboardViewController()
        let presenter = NewBookPresenter()
        let interactor = NewBookInteractor(bookDataManager: bookDataManager, userBooksDataManager: userBooksDataManager,
                                           userDataManager: userDataManager,
                                           firebaseAuthManager: firebaseAuthManager)

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
