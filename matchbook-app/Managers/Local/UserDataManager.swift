//
//  UserDataManager.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 07-09-21.
//

import Foundation

// MARK: - UserDataManagerProtocol
protocol UserDataManagerProtocol: AnyObject {
    func add(user: User, completion: CompletionHandler)
    func getUser() -> User?
    func getUserById(id: String) -> User?
    func deleteAll(completion: CompletionHandler)
}

// MARK: - UserDataManager
class UserDataManager: UserDataManagerProtocol {
    func add(user: User, completion: CompletionHandler) {
        RealmRepo<User>.add(
            item: user,
            completion: completion
        )
    }

    func getUser() -> User? {
        return RealmRepo<User>.getFirst()
    }
    
    func getUserById(id: String) -> User? {
        return RealmRepo<User>.getBy(key: "id", value: id)
    }

    func deleteAll(completion: CompletionHandler) {
        RealmRepo<User>.deleteAll(completion: completion)
    }
}
