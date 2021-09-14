//
//  BookFavorite.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 09-09-21.
//

import Foundation
import RealmSwift

// MARK: - BookFavorite
final class BookFavorite: DecodableObject, PrimaryKeyable {
    @objc dynamic var id: String = ""
    @objc dynamic var userId: String = ""
    var books = List<Book>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
