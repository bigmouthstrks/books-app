//
//  BookDetailPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 06-09-21.
//  
//

// MARK: - BookDetailPresenter
final class BookDetailPresenter {
    weak var view: BookDetailViewProtocol?
    var interactor: BookDetailInteractorProtocol?
    weak var delegate: BookDetailDelegate?
    
    var data: BookItemCellDataSource
    
    init(data: BookItemCellDataSource) {
        self.data = data
    }
}

// MARK: - BookDetailPresenterProtocol
extension BookDetailPresenter: BookDetailPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {
        view?.set(data: data)
    }
    
    func onViewWillAppear() {
        view?.showNavigationBar(animated: true)
        interactor?.setInitialLikeButtonState(for: data.id)
    }
    
    // MARK - View Events
    func likeButtonPressed() {
        interactor?.setLikeButton(for: data.id)
    }
}

// MARK: - BookDetailInteractorOutputProtocol
extension BookDetailPresenter: BookDetailInteractorOutputProtocol {
    func setupLike(with isLike: Bool) {
        view?.setupLikeButton(liked: isLike)
    }
    
    func removedLike() {
        view?.setupLikeButton(liked: false)
    }
    
    func addedLike() {
        view?.setupLikeButton(liked: true)
    }
}
