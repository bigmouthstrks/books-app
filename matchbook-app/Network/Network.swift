//
//  Network.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 21-08-21.
//

import Alamofire

// MARK: - StatusCode
enum StatusCode: Int {
    case ok = 200
    case created = 201
    case badRequest = 400
    case notAuthorized = 401
    case unprocessableEntity = 422
    case serviceError01 = 500
    case serviceError02 = 503
    case timedOut = 1001
}

// MARK: - Network
enum Network {
    private static func handle(statusCode: Int, completion: CompletionHandler) {
        switch statusCode {
        case 401: print("ERROR 401")
        default: break
        }
    }
    
    @discardableResult
    static func call<T: Decodable>(resource: URLRequestConvertible,
                                   onResponse: CompletionHandler = nil,
                                   onSuccess: SuccessHandler<T> = nil,
                                   onFailure: CompletionHandler = nil) -> DataRequest {
        var jsonDecoder: JSONDecoder {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return jsonDecoder
        }

        return AF
            .request(resource)
            .responseDecodable(decoder: jsonDecoder) { (response: AFDataResponse<T>) in
                
                if let statusCode = response.response?.statusCode {
                    handle(statusCode: statusCode) {
                        call(resource: resource,
                             onResponse: onResponse,
                             onSuccess: onSuccess,
                             onFailure: onFailure)
                    }
                }
                
                onResponse?()
                switch response.result {
                case .success(let decodedObject): onSuccess?(decodedObject)
                case .failure(let error):
                    print("Error on API call: \(error)")
                    onFailure?()
                }
            }
    }
}
