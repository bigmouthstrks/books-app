//
//  UserBooks.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 10-09-21.
//

import Foundation
import RealmSwift

// MARK: - UserBooks
final class UserBooks: DecodableObject, PrimaryKeyable {
    @objc dynamic var id: String = ""
    var books = List<Book>()
    
    enum CodingKeys: String, CodingKey {
        case id, books
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
