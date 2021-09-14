//
//  NewBookPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import Foundation

// MARK: - NewBookPresenter
final class NewBookPresenter {
    weak var view: NewBookViewProtocol?
    var interactor: NewBookInteractorProtocol?
    weak var delegate: NewBookDelegate?
}

// MARK: - NewBookPresenterProtocol
extension NewBookPresenter: NewBookPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    func onViewWillAppear() {}

    func onAddBookButtonPressed(title: String?, author: String?, editorial: String?, description: String?, releaseDate: Date, coverImage: URL?) {
        view?.startActivityIndicator()
        guard
            let title = title , !title.isEmpty,
            let author = author , !author.isEmpty,
            let editorial = editorial , !editorial.isEmpty,
            let description = description , !description.isEmpty,
            let coverImage = coverImage
        else {
            view?.stopActivityIndicator()
            view?.presentToastView(with: "Por favor complete todos los campos.")
            return
        }
        interactor?.addNewBook(title: title, author: author, editorial: editorial, description: description, releaseDate: releaseDate, coverImage: coverImage)
    }
    
    // MARK: - View events
    func onDismissButtonPressed() {
        delegate?.onDismissRequested()
    }
    
    func showImageSelection() {
        delegate?.onPresentImageSelectionRequested()
    }
}

// MARK: - NewBookInteractorOutputProtocol
extension NewBookPresenter: NewBookInteractorOutputProtocol {
    func onBookAdded() {
        view?.stopActivityIndicator()
        delegate?.onDismissRequested()
    }
}
