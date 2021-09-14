//
//  Editorial.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 07-09-21.
//

import RealmSwift

// MARK: - Editorial
final class Editorial: DecodableObject {
    @objc dynamic var editorialId: Int = -1
    @objc dynamic var name: String? = ""
    @objc dynamic var createdAt: String? = ""
    @objc dynamic var updatedAt: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case editorialId, name, createdAt, updatedAt
    }
}
