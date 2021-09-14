//
//  BookDetailProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 06-09-21.
//  
//

import UIKit

// MARK: - View
protocol BookDetailViewProtocol: NavigationBarVisibilityTogglable, ActivityIndicatorable, ToastViewable {
    func set(data: BookItemCellDataSource)
    func setupLikeButton(liked: Bool)
}

// MARK: - Interactor
protocol BookDetailInteractorProtocol: AnyObject {
    func setLikeButton(for bookId: String)
    func setInitialLikeButtonState(for bookId: String)
}

// MARK: - InteractorOutput
protocol BookDetailInteractorOutputProtocol: AnyObject {
    func removedLike()
    func addedLike()
    func setupLike(with isLike: Bool)
}

// MARK: - Presenter
protocol BookDetailPresenterProtocol: Viewlifecycleable {
    func likeButtonPressed()
}
