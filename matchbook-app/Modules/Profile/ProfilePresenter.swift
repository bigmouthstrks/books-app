//
//  ProfilePresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import Foundation

// MARK: - ProfilePresenter
final class ProfilePresenter {
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    weak var delegate: ProfileDelegate?
    
    private var dataSource: [BookItemCellDataSource]?
}

// MARK: - ProfilePresenterProtocol
extension ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - View lifecycle
    func onViewDidLoad() {
        view?.refreshData()
    }
    
    func onViewWillAppear() {
        view?.hideNavigationBar(animated: true)
        interactor?.getMyBooks()
        interactor?.getUserProfile()
        view?.refreshData()
    }

    // MARK: - View events
    func onLogoutButtonPressed() {
        view?.startActivityIndicator()
        interactor?.performLogout()
    }
    
    func countItems() -> Int {
        return dataSource?.count ?? .zero
    }
    
    func onEditProfileButtonPressed() {
        delegate?.onEditUserProfile()
    }
    
    func onAddBookButtonPressed() {
        delegate?.onAddBookRequested()
    }
    
    func onProfileImageUpdated(with url: URL?) {
        interactor?.storeProfileImage(url: url)
    }
}

// MARK: - ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    func onGetUserBooks(userBooks: UserBooks) {
        var newDataSource = [MyBookItemCellDataSource]()
        userBooks.books.forEach({ book in
            
            guard let title = book.title,
                  let thumbnail = book.thumbnail,
                  let url = URL(string: thumbnail),
                  let releaseDate = book.releaseDate,
                  let editorialName = book.editorial?.name else { return }
            
            let newBook: MyBookItemCellDataSource = MyBookViewModel(
                keyWords: [""],
                id: String(book.id),
                title: title,
                thumbnail: url,
                releaseDate: releaseDate,
                description: book.description,
                authorFirstName: book.author?.firstName ?? "",
                authorLastName: book.author?.lastName ?? "",
                authorPseudonym: book.author?.lastName ?? "",
                editorialName: book.editorial?.name ?? "")
            newDataSource.append(newBook)
        })
        newDataSource.reverse()
        view?.set(dataSource: newDataSource)
    }
    
    func onProfileFetched(with userData: User) {
        view?.setupUserProfile(with: userData)
    }
    
    func logoutPerformed() {
        view?.stopActivityIndicator()
        delegate?.onLogoutPerformed()
    }
}
