//
//  UserBooksDataManager.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 10-09-21.
//

import Foundation

// MARK: - UserBooksDataManagerProtocol
protocol UserBooksDataManagerProtocol: AnyObject {
    func add(book: UserBooks, completion: CompletionHandler)
    func getUserBooks(id: String) -> UserBooks?
    func deleteAll(completion: CompletionHandler)
}

// MARK: - UserBooksDataManager
class UserBooksDataManager: UserBooksDataManagerProtocol {
    func add(book: UserBooks, completion: CompletionHandler) {
        RealmRepo<UserBooks>.add(
            item: book,
            completion: completion
        )
    }

    func getUserBooks(id: String) -> UserBooks? {
        return RealmRepo<UserBooks>.getBy(key: "id", value: id)
    }

    func deleteAll(completion: CompletionHandler) {
        RealmRepo<UserBooks>.deleteAll(completion: completion)
    }
}
