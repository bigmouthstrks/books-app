//
//  OnboardingViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 30-08-21.
//  
//

import UIKit

// MARK: - OnboardingViewController
final class OnboardingViewController: UIViewController {
    var presenter: OnboardingPresenterProtocol?
    
    @IBOutlet weak var peopleDescriptionLabel: UILabel! {
        didSet {
            peopleDescriptionLabel.numberOfLines = 0
            peopleDescriptionLabel.text = "Encuentra libros de tu interés, a cambio de un libro que ya hayas leído."
            peopleDescriptionLabel.sizeToFit()
            peopleDescriptionLabel.adjustsFontSizeToFitWidth = true
        }
    }
        
    @IBOutlet weak var exchangeDescriptionLabel: UILabel! {
        didSet {
            exchangeDescriptionLabel.numberOfLines = 0
            exchangeDescriptionLabel.text = "Compra y vende libros nuevos o usados, y entrega a todo Chile."
            exchangeDescriptionLabel.sizeToFit()
            exchangeDescriptionLabel.adjustsFontSizeToFitWidth = true
        }
    }
            
    @IBOutlet weak var buyDescriptionLabel: UILabel! {
        didSet {
            buyDescriptionLabel.numberOfLines = 0
            buyDescriptionLabel.text = "Interactúa con usuarios de todo el país a través del ecosistema del libro."
            buyDescriptionLabel.sizeToFit()
            buyDescriptionLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.layer.cornerRadius = .defaultCornerRadius
            continueButton.addTarget(
                self,
                action: #selector(onContinueButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
}

// MARK: - Lifecycle
extension OnboardingViewController {
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
extension OnboardingViewController {
    @objc func onContinueButtonPressed(sender: UIButton) {
        presenter?.onContinueButtonPressed()
    }
}

// MARK: - OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewProtocol {}
