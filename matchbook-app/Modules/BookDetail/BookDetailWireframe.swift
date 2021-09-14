//
//  BookDetailWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 06-09-21.
//  
//

import UIKit

// MARK: - BookDetailDelegate
protocol BookDetailDelegate: AnyObject {}

// MARK: - BookDetailWireframe
enum BookDetailWireframe {
    static func createModule(with delegate: BookDetailDelegate, and book: BookItemCellDataSource) -> UIViewController {
        let firebaseAuthManager = FirebaseAuthRemoteManager()
        let bookDataManager = BookDataManager()
        let favoritesDataManager = FavoritesDataManager()
        let userDataManager = UserDataManager()
        
        let view = BookDetailViewController.storyboardViewController()
        let presenter = BookDetailPresenter(data: book)
        let interactor = BookDetailInteractor(bookDataManager: bookDataManager,
                                              favoritesDataManager: favoritesDataManager,
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
