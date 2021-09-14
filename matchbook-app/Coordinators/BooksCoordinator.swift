//
//  BooksCoordinator.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 26-08-21.
//

import UIKit

// MARK: - BooksCoordinatorProtocol
protocol BooksCoordinatorProtocol: Coordinator {}

// MARK: - BooksCoordinator
final class BooksCoordinator {
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.setDefaultConfiguration()
    }
}

// MARK: - BooksCoordinatorProtocol
extension BooksCoordinator: BooksCoordinatorProtocol {
    func start() {
        let booksViewController = BooksWireframe.createModule(with: self)
        navigationController.pushViewController(booksViewController, animated: true)
    }
}

// MARK: - BooksDelegate
extension BooksCoordinator: BooksDelegate {
    func onBookDetailRequested(book: BookItemCellDataSource) {
        let bookDetailViewController = BookDetailWireframe.createModule(with: self, and: book)
        navigationController.pushViewController(bookDetailViewController, animated: true)
    }
}

// MARK: - BookDetailDelegate
extension BooksCoordinator: BookDetailDelegate {}
