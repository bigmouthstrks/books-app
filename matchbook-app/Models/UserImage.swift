//
//  UserImage.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 10-09-21.
//

import Foundation

// MARK: - UserImage
final class UserImage: DecodableObject, PrimaryKeyable {
    @objc dynamic var id: String = ""
    @objc dynamic var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, url
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
