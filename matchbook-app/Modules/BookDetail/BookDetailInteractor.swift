//
//  BookDetailInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 06-09-21.
//  
//

import RealmSwift

// MARK: - BookDetailInteractor
final class BookDetailInteractor {
    required init(bookDataManager: BookDataManagerProtocol,
                  favoritesDataManager: FavoritesDataManagerProtocol,
                  userDataManager: UserDataManagerProtocol,
                  firebaseAuthManager: FirebaseAuthRemoteManagerProtocol) {
        self.bookDataManager = bookDataManager
        self.favoritesDataManager = favoritesDataManager
        self.userDataManager = userDataManager
        self.firebaseAuthManager = firebaseAuthManager
    }
    var firebaseAuthManager: FirebaseAuthRemoteManagerProtocol
    var userDataManager: UserDataManagerProtocol
    var favoritesDataManager: FavoritesDataManagerProtocol
    var bookDataManager: BookDataManagerProtocol
    weak var interactorOutput: BookDetailInteractorOutputProtocol?
}

// MARK: - BookDetailInteractorProtocol
extension BookDetailInteractor: BookDetailInteractorProtocol {
    func setLikeButton(for bookId: String) {
        guard let currentUserID = firebaseAuthManager.getCurrentFirUser()?.uid else {
            interactorOutput?.setupLike(with: false)
            return
        }
        
        guard let userFavorites = favoritesDataManager.getFavoritesWith(id: currentUserID) else { return }
        guard let bookToAdd = bookDataManager.getBookWith(id: bookId) else { return }
        
        if userFavorites.books.contains(bookToAdd) {
            
            let realm = try! Realm()
            try! realm.write {
                
                
                print(userFavorites.books.filter({ $0.id != Int(bookId) }))
                realm.add(userFavorites, update: .modified)
            }
            
        } else if !userFavorites.books.contains(bookToAdd) {
            interactorOutput?.setupLike(with: true)
        }
        
//        let realm = try! Realm()
//        try! realm.write {
//            userFavorites.books.append(bookToAdd)
//            realm.add(userFavorites, update: .modified)
//        }
    }
    
    func setInitialLikeButtonState(for bookId: String) {
        guard let currentUserID = firebaseAuthManager.getCurrentFirUser()?.uid else {
            interactorOutput?.setupLike(with: false)
            return
        }
        
        guard let userFavorites = favoritesDataManager.getFavoritesWith(id: currentUserID)
        else {
            interactorOutput?.setupLike(with: false)
            let favorites = BookFavorite()
            favorites.id = currentUserID
            favorites.books.append(Book())
            let realm = try! Realm()
            try! realm.write {
                realm.add(favorites, update: .modified)
            }
            return
        }
        
        guard let bookToAdd = bookDataManager.getBookWith(id: bookId) else { return }
        
        if userFavorites.books.contains(bookToAdd) {
            interactorOutput?.setupLike(with: true)
        } else if !userFavorites.books.contains(bookToAdd) {
            interactorOutput?.setupLike(with: false)
        }
        
//        let realm = try! Realm()
//        try! realm.write {
//            userFavorites.books.append(bookToAdd)
//            realm.add(userFavorites, update: .modified)
//        }
    }
    
    
//    func setInitialLikeButtonState(for bookId: String) {
//        guard let currentUserId = firebaseAuthManager.getCurrentFirUser()?.uid else {
//            // Ningún usuario ha iniciado sesión
//            return
//        }
//
//        guard
//            let user = userDataManager.getUserById(id: currentUserId),
//            let book = bookDataManager.getBookWith(id: bookId)
//        else { return }
//        print(book)
//        if user.favoriteBooks.contains(book) {
//            self.interactorOutput?.setupLike(with: true)
//        } else {
//            self.interactorOutput?.setupLike(with: false)
//        }
//    }
//
//    func setLikeButton(for bookId: String) {
//        guard let currentUserId = firebaseAuthManager.getCurrentFirUser()?.uid else {
//            // Ningún usuario ha iniciado sesión
//            return
//        }
//
//        guard
//            let user = userDataManager.getUserById(id: currentUserId),
//            let book = bookDataManager.getBookWith(id: bookId)
//        else { return }
//
//        if user.favoriteBooks.contains(book) {
//            print("QUITAR LIKE")
//            self.interactorOutput?.removedLike()
//        } else if !user.favoriteBooks.contains(book) {
//            print("AGREGAR LIKE")
//            self.interactorOutput?.addedLike()
//        }
//    }
}
