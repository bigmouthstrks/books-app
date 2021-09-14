//
//  NewBookInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import Foundation
import RealmSwift

// MARK: - NewBookInteractor
final class NewBookInteractor {
    required init(bookDataManager: BookDataManagerProtocol,
                  userBooksDataManager: UserBooksDataManagerProtocol,
                  userDataManager: UserDataManagerProtocol,
                  firebaseAuthManager: FirebaseAuthRemoteManagerProtocol) {
        self.bookDataManager = bookDataManager
        self.userBooksDataManager = userBooksDataManager
        self.userDataManager = userDataManager
        self.firebaseAuthManager = firebaseAuthManager
    }
    var userDataManager: UserDataManagerProtocol
    var userBooksDataManager: UserBooksDataManagerProtocol
    var bookDataManager: BookDataManagerProtocol
    var firebaseAuthManager: FirebaseAuthRemoteManagerProtocol
    weak var interactorOutput: NewBookInteractorOutputProtocol?
}

// MARK: - NewBookInteractorProtocol
extension NewBookInteractor: NewBookInteractorProtocol {
    func addNewBook(title: String, author: String, editorial: String, description: String, releaseDate: Date, coverImage: URL) {
        let fullName = author.components(separatedBy: "")
        let newId = RealmRepo<Book>.getAll().count + 1
        
        let newEditorial = Editorial()
        let newAuthor = Author()
        let newBook = Book()
        newBook.id = newId
        newBook.title = title
        
        newBook.author = newAuthor
        newBook.author?.firstName = fullName[0]
        newBook.author?.lastName = ""
        
        newBook.editorial = newEditorial
        newBook.editorial?.name = editorial
        
        newBook.bookDescription = description
        newBook.releaseDate = "\(releaseDate)"
        newBook.thumbnail = coverImage.absoluteString
        
        guard let currentUserID = firebaseAuthManager.getCurrentFirUser()?.uid else { return }
        
        guard let existingUserBooks = userBooksDataManager.getUserBooks(id: currentUserID) else { return }
        
        
        let realm = try! Realm()
        try! realm.write {
            existingUserBooks.books.append(newBook)
            realm.add(existingUserBooks, update: .modified)
        }
        
        print(userBooksDataManager.getUserBooks(id: currentUserID))
        
        bookDataManager.add(book: newBook, completion: {
            self.interactorOutput?.onBookAdded()
        })
    }
}
