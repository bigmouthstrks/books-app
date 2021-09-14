//
//  Book.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 01-09-21.
//

import Foundation
import RealmSwift

// MARK: - Book
final class Book: DecodableObject {
    @objc dynamic var id: Int = -1
    @objc dynamic var title: String? = ""
    @objc dynamic var releaseDate: String? = ""
    @objc dynamic var thumbnail: String? = ""
    @objc dynamic var bookDescription: String? = ""
    @objc dynamic var shortDescription: String? = ""
    var keyWords: [String]?
    @objc dynamic var categoryId: Int = -1
    @objc dynamic var genreId: Int = -1
    @objc dynamic var editorialId: Int = -1
    @objc dynamic var authorId: Int = -1
    @objc dynamic var languageId: Int = -1
    @objc dynamic var createdAt: String? = ""
    @objc dynamic var updatedAt: String? = ""
    
    @objc dynamic var editorial: Editorial?
    @objc dynamic var author: Author?
    
    enum CodingKeys: String, CodingKey {
        case id, title, releaseDate, thumbnail, shortDescription, categoryId, genreId, editorialId, authorId, languageId, editorial, author
        case bookDescription = "description"
        case keyWords = "key_words"
    }
}
