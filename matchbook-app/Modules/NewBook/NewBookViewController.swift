//
//  NewBookViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 07-09-21.
//  
//

import UIKit
import PhotosUI

// MARK: - NewBookViewController
final class NewBookViewController: UIViewController {
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var editorialTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var keyWordsTextField: UITextField!
    @IBOutlet weak var releaseDatePicker: UIDatePicker!
    
    @IBOutlet weak var addCoverImageButton: UIButton! {
        didSet {
            addCoverImageButton.addTarget(
                self,
                action: #selector(onAddCoverImageButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.addTarget(
                self,
                action: #selector(onDismissButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var addBookButton: UIButton! {
        didSet {
            addBookButton.layer.cornerRadius = .defaultCornerRadius
            addBookButton.addTarget(
                self,
                action: #selector(onAddBookButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    var presenter: NewBookPresenterProtocol?
    var bookCoverImage: URL?
}

// MARK: - Lifecycle
extension NewBookViewController {
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
extension NewBookViewController {
    @objc func onAddBookButtonPressed(sender: UIButton) {
        presenter?.onAddBookButtonPressed(title: bookTitleTextField.text, author: authorTextField.text, editorial: editorialTextField.text, description: descriptionTextView.text, releaseDate: releaseDatePicker.date, coverImage: bookCoverImage)
    }
    
    @objc func onDismissButtonPressed(sender: UIButton) {
        presenter?.onDismissButtonPressed()
    }
    
    @objc func onAddCoverImageButtonPressed(sender: UIButton) {
        showImageSelection()
    }
}

// MARK: - NewBookViewProtocol
extension NewBookViewController: NewBookViewProtocol {}

// MARK: - UINavigationControllerDelegate
extension NewBookViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func showImageSelection() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            bookCoverImage = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
