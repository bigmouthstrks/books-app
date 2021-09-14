//
//  Parameters.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 02-09-21.
//

import Alamofire

// MARK: - Parameterizable
protocol Parameterizable {
    var asParameters: Parameters { get }
}
