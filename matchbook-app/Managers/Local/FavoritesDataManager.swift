//
//  FavoritesDataManager.swift
//  Matchfavorite
//
//  Created by Benjamin Cáceres on 09-09-21.
//

import Foundation

// MARK: - FavoritesDataManagerProtocol
protocol FavoritesDataManagerProtocol: AnyObject {
    func add(favorite: BookFavorite, completion: CompletionHandler)
    func getFavoritesWith(id: String) -> BookFavorite?
    func deleteAll(completion: CompletionHandler)
}

// MARK: - FavoritesDataManager
class FavoritesDataManager: FavoritesDataManagerProtocol {
    func add(favorite: BookFavorite, completion: CompletionHandler) {
        RealmRepo<BookFavorite>.add(
            item: favorite,
            completion: completion
        )
    }

    func getFavoritesWith(id: String) -> BookFavorite? {
        return RealmRepo<BookFavorite>.getBy(key: "id", value: id)
    }

    func deleteAll(completion: CompletionHandler) {
        RealmRepo<BookFavorite>.deleteAll(completion: completion)
    }
}
