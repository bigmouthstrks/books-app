//
//  MainTabBarProtocols.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import UIKit

// MARK: - View
protocol MainTabBarViewProtocol: AnyObject {
    func addBottomNavBarAsSubView()
    func setBottomNavBarFrame()
    func select(tab: Tabs)
}

// MARK: - Interactor
protocol MainTabBarInteractorProtocol: AnyObject {}

// MARK: - InteractorOutput
protocol MainTabBarInteractorOutputProtocol: AnyObject {}

// MARK: - Presenter
protocol MainTabBarPresenterProtocol: Viewlifecycleable {}
