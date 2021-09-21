//
//  NetworkRouter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//

import Alamofire
import Foundation

// MARK: - NetworkRouter
enum NetworkRouter {
    case getBook(id: String)
    case getBooks
}

// MARK: - URLRequestConvertible
extension NetworkRouter: URLRequestConvertible {
    // MARK: - path
    var path: String {
        switch self {
        case .getBook(let id): return "/books/\(id)"
        case .getBooks: return "/books"
        }
    }

    // MARK: - baseURL
    var baseURL: URL? { return APIEnvironment.baseURL }

    // MARK: - URL
    var url: URL? {
        guard
            let _baseURL = baseURL,
            let components = URLComponents(url: _baseURL, resolvingAgainstBaseURL: true) else { return nil }

        return components.url?.appendingPathComponent(path)
    }
        
    // MARK: - method
    var method: HTTPMethod {
        switch self {
        case .getBooks, .getBook: return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getBooks, .getBook: return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = url else { return URLRequest(url: URL(string: "")!) }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        defer {
            print("urlRequest: \(urlRequest)")
            print("urlRequest.allHTTPHeaderFields: \(String(describing: urlRequest.allHTTPHeaderFields))")
            print("Parameters: \(parameters)")
        }
        
//        switch self {
//        case .getBook, .getBooks: urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        }
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
