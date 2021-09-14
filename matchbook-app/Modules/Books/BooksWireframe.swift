//
//  BooksWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 31-08-21.
//  
//

import UIKit

// MARK: - BooksDelegate
protocol BooksDelegate: AnyObject {
    func onBookDetailRequested(book: BookItemCellDataSource)
}

// MARK: - BooksWireframe
enum BooksWireframe {
    static func createModule(with delegate: BooksDelegate) -> UIViewController {
        let booksRemoteManager = BooksRemoteManager()
        let bookDataManager = BookDataManager()
        
        let view = BooksViewController.storyboardViewController()
        let presenter = BooksPresenter()
        let interactor = BooksInteractor(booksRemoteManager: booksRemoteManager, bookDataManager: bookDataManager)
        
        booksRemoteManager.managerOutput = interactor

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
