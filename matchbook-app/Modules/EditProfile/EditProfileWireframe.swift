//
//  EditProfileWireframe.swift
//  matchbook-app-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import UIKit

// MARK: - EditProfileDelegate
protocol EditProfileDelegate: AnyObject {
    func onDismissRequested()
    func onUpdatePasswordRequested()
    func onUpdateEmailRequested()
}

// MARK: - EditProfileWireframe
enum EditProfileWireframe {
    static func createModule(with delegate: EditProfileDelegate) -> UIViewController {
        let view = EditProfileViewController.storyboardViewController()
        let presenter = EditProfilePresenter()
        let interactor = EditProfileInteractor()
        
        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
