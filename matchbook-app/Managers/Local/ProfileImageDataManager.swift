//
//  ProfileImageDataManager.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 10-09-21.
//

import Foundation

// MARK: - ProfileImageDataManagerProtocol
protocol ProfileImageDataManagerProtocol: AnyObject {
    func add(image: UserImage, completion: CompletionHandler)
    func getUserImage(id: String) -> UserImage?
}

// MARK: - ProfileImageDataManager
class ProfileImageDataManager: ProfileImageDataManagerProtocol {
    func add(image: UserImage, completion: CompletionHandler) {
        RealmRepo.add(
            item: image,
            completion: completion
        )
    }
    
    func getUserImage(id: String) -> UserImage? {
        return RealmRepo<UserImage>.getBy(key: "id", value: id)
    }
}
