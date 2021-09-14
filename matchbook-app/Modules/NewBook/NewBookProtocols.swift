//
//  NewBookProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import UIKit

// MARK: - View
protocol NewBookViewProtocol: ToastViewable, NavigationBarVisibilityTogglable, ActivityIndicatorable {}

// MARK: - Interactor
protocol NewBookInteractorProtocol: AnyObject {
    func addNewBook(title: String, author: String, editorial: String, description: String, releaseDate: Date, coverImage: URL)
}

// MARK: - InteractorOutput
protocol NewBookInteractorOutputProtocol: AnyObject {
    func onBookAdded()
}

// MARK: - Presenter
protocol NewBookPresenterProtocol: Viewlifecycleable {
    func onDismissButtonPressed()
    func onAddBookButtonPressed(title: String?, author: String?, editorial: String?, description: String?, releaseDate: Date, coverImage: URL?)
    func showImageSelection()
}
