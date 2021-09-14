//
//  Author.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 07-09-21.
//

import Foundation
import RealmSwift

// MARK: - Author
final class Author: DecodableObject {
    @objc dynamic var authorId: Int = -1
    @objc dynamic var firstName: String? = ""
    @objc dynamic var lastName: String? = ""
    @objc dynamic var pseudonym: String? = ""
    @objc dynamic var createdAt: String? = ""
    @objc dynamic var updatedAt: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case authorId, firstName, lastName, pseudonym, createdAt, updatedAt
    }
}
