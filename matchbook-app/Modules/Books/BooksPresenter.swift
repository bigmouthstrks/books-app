//
//  BooksPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 31-08-21.
//  
//

import Foundation

// MARK: - BooksPresenter
final class BooksPresenter {
    weak var view: BooksViewProtocol?
    var interactor: BooksInteractorProtocol?
    weak var delegate: BooksDelegate?
}

// MARK: - BooksPresenterProtocol
extension BooksPresenter: BooksPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    
    func onViewWillAppear() {
        view?.startActivityIndicator()
        interactor?.getBooks()
        view?.hideNavigationBar(animated: true)
    }
    
    // MARK: - View Events
    func didSelectItem(item: BookItemCellDataSource) {
        delegate?.onBookDetailRequested(book: item)
    }
}

// MARK: - BooksInteractorOutputProtocol
extension BooksPresenter: BooksInteractorOutputProtocol {
    func onBooksLoaded(books: GetBooksResponse) {
        view?.stopActivityIndicator()
        
        guard let books = books.books else { return }
        var newDataSource = [BookItemCellDataSource]()
        books.forEach({ currentBook in
            guard
                let author = currentBook.author,
                let editorial = currentBook.editorial,
                let name = author.firstName,
                let lastName = author.lastName,
                let description = currentBook.bookDescription,
                let pseudonym = author.pseudonym,
                let editorial = editorial.name,
                let releaseDate = currentBook.releaseDate,
                let title = currentBook.title,
                let thumbnail = currentBook.thumbnail,
                let thumbnailURL = URL(string: thumbnail)
            else { return }
            
            let id = String(currentBook.id)
            
            let book: BookItemCellDataSource = BookViewModel(keyWords: [], id: id, title: title, thumbnail: thumbnailURL, releaseDate: releaseDate, description: description, authorFirstName: name, authorLastName: lastName, authorPseudonym: pseudonym, editorialName: editorial)
            
            newDataSource.append(book)
        })
        view?.set(dataSource: newDataSource)
    }
}
