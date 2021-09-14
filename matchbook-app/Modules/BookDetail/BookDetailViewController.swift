//
//  BookDetailViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 06-09-21.
//  
//

import UIKit

// MARK: - BookDetailViewController
final class BookDetailViewController: UIViewController {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var editorialNameLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.addTarget(
                self,
                action: #selector(likeButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    
    var presenter: BookDetailPresenterProtocol?
}

// MARK: - Lifecycle
extension BookDetailViewController {
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
extension BookDetailViewController {
    @objc func likeButtonPressed(sender: UIButton) {
        presenter?.likeButtonPressed()
    }
}

// MARK: - BookDetailViewProtocol
extension BookDetailViewController: BookDetailViewProtocol {
    func setupLikeButton(liked: Bool) {
        switch liked {
        case true: likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        case false: likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func set(data: BookItemCellDataSource) {
        authorNameLabel.text = "\(data.authorFirstName) \(data.authorLastName)"
        editorialNameLabel.text = "Publicado por Editorial \(data.editorialName)"
        releaseDateLabel.text = data.releaseDate
        
        titleLabel.text = data.title
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        
        descriptionLabel.text = data.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        coverImage.setImage(with: data.thumbnail)
    }
}
