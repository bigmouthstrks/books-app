//
//  MainTabBarWireframe.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import UIKit

// MARK: - MainTabBarDelegate
protocol MainTabBarDelegate: AnyObject {}

// MARK: - MainTabBarWireframe
enum MainTabBarWireframe {
    static func createModule() -> UITabBarController {
        let view = MainTabBarViewController.storyboardViewController()
        let interactor = MainTabBarInteractor()
        let presenter = MainTabBarPresenter()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor

        interactor.interactorOutput = presenter
        
        return view
    }
}
