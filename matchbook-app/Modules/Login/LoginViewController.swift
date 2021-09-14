//
//  LoginViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 16-08-21.
//  
//

import UIKit

// MARK: - LoginViewController
final class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var resetPasswordButton: UIButton! {
        didSet {
            resetPasswordButton.addTarget(
                self,
                action: #selector(onResetPasswordButtonPressed(sender:)),
                for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var createAccountButton: UIButton! {
        didSet {
            createAccountButton.layer.cornerRadius = .defaultCornerRadius
            createAccountButton.tintColor = .secondary
            createAccountButton.addTarget(
                self,
                action: #selector(onCreateAccountButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = .defaultCornerRadius
            loginButton.tintColor = .primaryDark
            loginButton.addTarget(
                self,
                action: #selector(onLoginButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
}

// MARK: - Lifecycle
extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onViewWillAppear()
    }
}

// MARK - Targets
extension LoginViewController {
    @objc func onCreateAccountButtonPressed(sender: UIButton) {
        presenter?.onCreateAccount()
    }
    
    @objc func onLoginButtonPressed(sender: UIButton) {
        presenter?.onLogin(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func onResetPasswordButtonPressed(sender: UIButton) {
        presenter?.onResetPassword(email: emailTextField.text)
    }
}

// MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {}
