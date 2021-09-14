//
//  MainTabBarPresenter.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

// MARK: - MainTabBarPresenter
final class MainTabBarPresenter {
    weak var view: MainTabBarViewProtocol?
    var interactor: MainTabBarInteractorProtocol?
}

// MARK: - MainTabBarPresenterProtocol
extension MainTabBarPresenter: MainTabBarPresenterProtocol {

    // MARK: - View lifecycle
    func onViewDidLoad() {}
    func onViewWillLayoutSubviews() {}
    
    func onViewWillAppear() {
        view?.setBottomNavBarFrame()
        view?.select(tab: .books)
        view?.addBottomNavBarAsSubView()
    }

    // MARK: - View events
}

// MARK: - MainTabBarInteractorOutputProtocol
extension MainTabBarPresenter: MainTabBarInteractorOutputProtocol {}
