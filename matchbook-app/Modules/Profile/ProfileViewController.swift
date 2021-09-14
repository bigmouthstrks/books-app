//
//  ProfileViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import UIKit

// MARK: - ProfileViewController
final class ProfileViewController: UIViewController {
    @IBOutlet weak var displayNameLabel: UILabel!

    @IBOutlet weak var regionLabel: UILabel! {
        didSet {
            regionLabel.text = Locale.current.regionCode
        }
    }
    
    @IBOutlet weak var myBooksCollectionView: UICollectionView! {
        didSet {
            myBooksCollectionView.backgroundColor = .coldNeutral2
        }
    }
    
    @IBOutlet weak var newBookButton: UIButton! {
        didSet {
            newBookButton.addTarget(
                self,
                action: #selector(onAddBookButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var editProfileButton: UIButton! {
        didSet {
            editProfileButton.layer.cornerRadius = .defaultButtonCornerRadius
            editProfileButton.addTarget(
                self,
                action: #selector(onEditProfileButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.addTarget(
                self,
                action: #selector(onLogoutButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.borderWidth = 0
            profileImage.layer.masksToBounds = false
            profileImage.layer.borderColor = UIColor.black.cgColor
            profileImage.layer.cornerRadius = profileImage.frame.height/2
            profileImage.clipsToBounds = true
            
            profileImage.isUserInteractionEnabled = true

            let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onEditProfileImagePressed(recognizer:)))
            profileImage.addGestureRecognizer(singleTap)
        }
    }
    
    var presenter: ProfilePresenterProtocol?
    var profileImageURL: URL?
    var dataSource = [MyBookItemCellDataSource]()
}

// MARK: - Lifecycle
extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        myBooksCollectionView.delegate = self
        myBooksCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
        presenter?.onViewWillAppear()
    }
}

// MARK: - Button Targets
extension ProfileViewController {
    @objc func onLogoutButtonPressed(sender: UIButton) {
        presenter?.onLogoutButtonPressed()
    }
    
    @objc func onEditProfileButtonPressed(sender: UIButton) {
        presenter?.onEditProfileButtonPressed()
    }
    
    @objc func onAddBookButtonPressed(sender: UIButton) {
        presenter?.onAddBookButtonPressed()
    }
    
    @objc func onEditProfileImagePressed(recognizer: UIGestureRecognizer) {
        showImageSelection()
    }
}

// MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    func refreshData() {
        myBooksCollectionView.reloadData()
    }
    
    func setupUserProfile(with userData: User) {
        displayNameLabel.text = userData.firstName
        profileImage.setImage(with: URL(string: userData.profileImage))
    }
    
    func set(dataSource: [MyBookItemCellDataSource]) {
        self.dataSource.removeAll()
        self.dataSource.append(contentsOf: dataSource)
        
        myBooksCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBookItemCell.reuseIdentifier, for: indexPath)
        guard let myBookItemCell = cell as? MyBookItemCell else { return cell }
        
        let dataSource = dataSource[indexPath.item]
        
        myBookItemCell.dataSource = dataSource
        myBookItemCell.delegate = self
        
        return myBookItemCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2.3
        let height = UIScreen.main.bounds.height / 2.4
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func showImageSelection() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            profileImage.setImage(with: imageURL)
            profileImageURL = imageURL
            presenter?.onProfileImageUpdated(with: imageURL)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - MyBookItemCellDelegate
extension ProfileViewController: MyBookItemCellDelegate {
    func reloadData() {
        myBooksCollectionView.reloadData()
    }
}
