//
//  EditProfileFieldViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 09-09-21.
//  
//

import UIKit

// MARK: - EditProfileFieldViewController
final class EditProfileFieldViewController: UIViewController {
    @IBOutlet weak var newPassWordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var updatePasswordButton: UIButton! {
        didSet {
            updatePasswordButton.layer.cornerRadius = .defaultCornerRadius
            updatePasswordButton.addTarget(
                self,
                action: #selector(onUpdatePasswordButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var updateEmailButton: UIButton! {
        didSet {
            updateEmailButton.layer.cornerRadius = .defaultCornerRadius
            updateEmailButton.addTarget(
                self,
                action: #selector(onUpdateEmailButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var updateEmailStackView: UIStackView! {
        didSet {
            updateEmailStackView.layer.cornerRadius = .defaultCornerRadius
        }
    }
    
    @IBOutlet weak var updatePasswordStackView: UIStackView! {
        didSet {
            updatePasswordStackView.layer.cornerRadius = .defaultCornerRadius
        }
    }
    
    var presenter: EditProfileFieldPresenterProtocol?
}

// MARK: - Lifecycle
extension EditProfileFieldViewController {
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
extension EditProfileFieldViewController {
    @objc func onUpdateEmailButtonPressed(sender: UIButton) {
        presenter?.onUpdateEmailButtonPressed(newEmail: newEmailTextField.text, confirmEmail: confirmPasswordTextField.text)
    }
    
    @objc func onUpdatePasswordButtonPressed(sender: UIButton) {
        presenter?.onUpdatePasswordButtonPressed(newPassword: newPassWordTextField.text, confirmPassword: confirmPasswordTextField.text)
    }
}

// MARK: - EditProfileFieldViewProtocol
extension EditProfileFieldViewController: EditProfileFieldViewProtocol {    
    func hideEmailStackView() {
        updateEmailStackView.isHidden = true
        updateEmailButton.isHidden = true
        confirmEmailTextField.isHidden = true
        newEmailTextField.isHidden = true
    }
    
    func hidePasswordStackView() {
        updatePasswordStackView.isHidden = true
        updatePasswordButton.isHidden = true
        confirmPasswordTextField.isHidden = true
        newPassWordTextField.isHidden = true
    }
}
