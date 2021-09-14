//
//  MainTabBarInteractor.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

// MARK: - MainTabBarInteractor
final class MainTabBarInteractor {
    required init() {}
    weak var interactorOutput: MainTabBarInteractorOutputProtocol?
}

// MARK: - MainTabBarInteractorProtocol
extension MainTabBarInteractor: MainTabBarInteractorProtocol {}
