//
//  AppEnvironment.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 02-09-21.
//

import Foundation

// MARK: - APIEnvironment
enum APIEnvironment {
    static var baseURL: URL? {
        return URL(string: "https://matchbook-backend.herokuapp.com")
    }
}
