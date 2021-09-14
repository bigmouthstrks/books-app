//
//  BookResponses.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 02-09-21.
//

import Alamofire
import RealmSwift

// MARK: - GetBooksResponse
struct GetBooksResponse: Decodable {
    var books: [Book]?
}
