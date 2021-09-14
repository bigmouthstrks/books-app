//
//  TypeAliases.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 02-09-21.
//

import RealmSwift

// MARK: - Typealias
typealias DecodableObject = Decodable & Object
typealias CodableObject = Codable & Object
typealias CompletionHandler = (() -> Void)?
typealias SuccessHandler<T> = ((T) -> Void)?
