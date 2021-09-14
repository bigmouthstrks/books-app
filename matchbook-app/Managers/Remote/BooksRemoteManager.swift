//
//  BooksRemoteManager.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 02-09-21.
//

import Foundation

// MARK: - BooksRemoteManagerProtocol
protocol BooksRemoteManagerProtocol: AnyObject {
    func getBooks()
}

// MARK: - BooksRemoteManagerOutputProtocol
protocol BooksRemoteManagerOutputProtocol: AnyObject {
    func onBooksResponseResponse()
    func onBooksResponseSuccess(response: GetBooksResponse)
    func onBooksResponseFailed()
}

// MARK: - BooksRemoteManager
final class BooksRemoteManager {
    weak var managerOutput: BooksRemoteManagerOutputProtocol?
}

// MARK: - BooksRemoteManagerProtocol
extension BooksRemoteManager: BooksRemoteManagerProtocol {
    func getBooks() {
        Network.call(
            resource: NetworkRouter.getBooks,
            onResponse: { [weak self] in
                guard let self = self else { return }
                self.managerOutput?.onBooksResponseResponse()
            }, onSuccess: { [weak self] (response: GetBooksResponse) in
                guard let self = self else { return }
                self.managerOutput?.onBooksResponseSuccess(response: response)
            }, onFailure: { [weak self] in
                guard let self = self else { return }
                self.managerOutput?.onBooksResponseFailed()
            })
    }
}
