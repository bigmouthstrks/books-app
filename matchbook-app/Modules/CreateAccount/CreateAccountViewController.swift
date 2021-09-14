//
//  CreateAccountViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 20-08-21.
//  
//

import UIKit

// MARK: - CreateAccountViewController
final class CreateAccountViewController: UIViewController {
    var presenter: CreateAccountPresenterProtocol?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton! {
        didSet {
            createAccountButton.layer.cornerRadius = .defaultCornerRadius
            createAccountButton.addTarget(
                self,
                action: #selector(onCreateAccountButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
}

// MARK: - Lifecycle
extension CreateAccountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setDefaultConfiguration()
        presenter?.onViewWillAppear()
    }
}

// MARK - Targets
extension CreateAccountViewController {
    @objc func onCreateAccountButtonPressed(sender: UIButton) {
        presenter?.onCreateAccount(email: emailTextField.text, password: passwordTextField.text, firstName: firstNameTextField.text, lastName: lastNameTextField.text)
    }
}

// MARK: - CreateAccountViewProtocol
extension CreateAccountViewController: CreateAccountViewProtocol {}
