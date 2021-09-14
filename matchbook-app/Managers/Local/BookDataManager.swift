//
//  BookDataManager.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 09-09-21.
//

import Foundation

// MARK: - BookDataManagerProtocol
protocol BookDataManagerProtocol: AnyObject {
    func add(book: Book, completion: CompletionHandler)
    func getBookWith(id: String) -> Book?
    func deleteAll(completion: CompletionHandler)
}

// MARK: - BookDataManager
class BookDataManager: BookDataManagerProtocol {
    func add(book: Book, completion: CompletionHandler) {
        RealmRepo<Book>.add(
            item: book,
            completion: completion
        )
    }

    func getBookWith(id: String) -> Book? {
        return RealmRepo<Book>.getBy(key: "id", value: Int(id))
    }

    func deleteAll(completion: CompletionHandler) {
        RealmRepo<Book>.deleteAll(completion: completion)
    }
}
