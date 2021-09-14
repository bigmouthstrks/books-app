//
//  BooksProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 31-08-21.
//  
//

import UIKit

// MARK: - View
protocol BooksViewProtocol: ToastViewable, ActivityIndicatorable, NavigationBarVisibilityTogglable {
    func set(dataSource: [BookItemCellDataSource])
}

// MARK: - Interactor
protocol BooksInteractorProtocol: AnyObject {
    func getBooks()
}

// MARK: - InteractorOutput
protocol BooksInteractorOutputProtocol: AnyObject {
    func onBooksLoaded(books: GetBooksResponse) 
}

// MARK: - Presenter
protocol BooksPresenterProtocol: Viewlifecycleable {
    func didSelectItem(item: BookItemCellDataSource)
}
