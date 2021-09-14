//
//  ProfileProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import UIKit

// MARK: - View
protocol ProfileViewProtocol: ActivityIndicatorable, NavigationBarVisibilityTogglable, ToastViewable {
    func setupUserProfile(with userData: User)
    func set(dataSource: [MyBookItemCellDataSource])
    func refreshData()
}

// MARK: - Interactor
protocol ProfileInteractorProtocol: AnyObject {
    func performLogout()
    func getUserProfile()
    func storeProfileImage(url: URL?)
    func getMyBooks()
}

// MARK: - InteractorOutput
protocol ProfileInteractorOutputProtocol: AnyObject {
    func logoutPerformed()
    func onProfileFetched(with userData: User)
    func onGetUserBooks(userBooks: UserBooks)
}

// MARK: - Presenter
protocol ProfilePresenterProtocol: Viewlifecycleable {
    func onLogoutButtonPressed()
    func countItems() -> Int
    func onEditProfileButtonPressed()
    func onAddBookButtonPressed()
    func onProfileImageUpdated(with url: URL?)
}
