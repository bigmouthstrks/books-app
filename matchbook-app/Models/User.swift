//
//  User.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 21-08-21.
//

import Foundation
import RealmSwift

// MARK: - User
final class User: DecodableObject {
    @objc dynamic var id: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var profileImage: String = ""
    var favoriteBooks = List<Book>()
    
    enum CodingKeys: String, CodingKey {
        case id, email, firstName, lastName, profileImage, favoriteBooks
    }
}
