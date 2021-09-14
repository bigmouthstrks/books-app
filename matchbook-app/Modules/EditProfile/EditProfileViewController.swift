//
//  EditProfileViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import UIKit

// MARK: - EditProfileViewController
final class EditProfileViewController: UIViewController {
    @IBOutlet weak var updateEmailButton: UIButton! {
        didSet {
            updateEmailButton.tintColor = .primaryDark
            updateEmailButton.addTarget(
                self,
                action: #selector(onUpdateEmailButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }

    @IBOutlet weak var updatePasswordButton: UIButton! {
        didSet {
            updatePasswordButton.tintColor = .primaryDark
            updatePasswordButton.addTarget(
                self,
                action: #selector(onUpdatePasswordButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.addTarget(
                self,
                action: #selector(onCancelButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    var presenter: EditProfilePresenterProtocol?
}

// MARK: - Lifecycle
extension EditProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onViewWillAppear()
    }
}

// MARK: - Button Targets
extension EditProfileViewController {
    @objc func onCancelButtonPressed(sender: UIButton) {
        presenter?.onCancelButtonPressed()
    }
    
    @objc func onUpdatePasswordButtonPressed(sender: UIButton) {
        presenter?.onUpdatePasswordButtonPressed()
    }
    
    @objc func onUpdateEmailButtonPressed(sender: UIButton) {
        presenter?.onUpdateEmailButtonPressed()
    }
}

// MARK: - EditProfileViewProtocol
extension EditProfileViewController: EditProfileViewProtocol {}
