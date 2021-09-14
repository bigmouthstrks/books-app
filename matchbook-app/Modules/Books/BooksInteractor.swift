//
//  BooksInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 31-08-21.
//  
//

// MARK: - BooksInteractor
final class BooksInteractor {
    required init(booksRemoteManager: BooksRemoteManagerProtocol,
                  bookDataManager: BookDataManagerProtocol) {
        self.booksRemoteManager = booksRemoteManager
        self.bookDataManager = bookDataManager
    }
    var bookDataManager: BookDataManagerProtocol
    var booksRemoteManager: BooksRemoteManagerProtocol
    weak var interactorOutput: BooksInteractorOutputProtocol?
}

// MARK: - BooksInteractorProtocol
extension BooksInteractor: BooksInteractorProtocol {
    func getBooks() {
        booksRemoteManager.getBooks()
    }
}

// MARK: - BooksRemoteManagerOutputProtocol
extension BooksInteractor: BooksRemoteManagerOutputProtocol {
    func onBooksResponseResponse() {}
    
    func onBooksResponseSuccess(response: GetBooksResponse) {
        interactorOutput?.onBooksLoaded(books: response)
    }
    
    func onBooksResponseFailed() {
        
    }
}
