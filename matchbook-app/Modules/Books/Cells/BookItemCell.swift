//
//  BookItemCell.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 01-09-21.
//

import UIKit

// MARK: - BookItemCellDelegate
protocol BookItemCellDelegate: AnyObject {
    func reloadData()
}

// MARK: - BookItemCellDataSource
protocol BookItemCellDataSource: DataSource {
    var id: String { get set }
    var title: String { get set }
    var thumbnail: URL { get set }
    var releaseDate: String { get set }
    var description: String { get set }
    var keyWords: [String] { get set }
    var authorFirstName: String { get set }
    var authorLastName: String { get set }
    var authorPseudonym: String { get set }
    var editorialName: String { get set }
}

// MARK: - BookViewModel
struct BookViewModel: BookItemCellDataSource {
    var keyWords: [String]
    var id: String
    var title: String
    var thumbnail: URL
    var releaseDate: String
    var description: String
    var authorFirstName: String
    var authorLastName: String
    var authorPseudonym: String
    var editorialName: String
}

// MARK: - BooksCell
final class BookItemCell: UICollectionViewCell {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var dataSource: BookItemCellDataSource? {
        didSet {
            guard let dataSource = dataSource else { return }
            setDefaultConfig()
            coverImage.setImage(with: dataSource.thumbnail)
            
            titleLabel.text = dataSource.title
            titleLabel.sizeToFit()
            authorLabel.text = "\(dataSource.authorFirstName) \(dataSource.authorLastName)"
            authorLabel.sizeToFit()
        }
    }
    
    static let reuseIdentifier = "bookItem"
    weak var delegate: BookItemCellDelegate!
}

extension BookItemCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        authorLabel.text = nil
    }
}

extension BookItemCell {
    func setDefaultConfig() {
        self.layer.cornerRadius = .defaultCornerRadius
        self.layer.shadowColor = UIColor.primaryLight.cgColor
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowRadius = 20
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.primaryLight.cgColor
        
        self.titleLabel.numberOfLines = 0
        self.titleLabel.sizeToFit()
        
        self.authorLabel.numberOfLines = 0
        self.authorLabel.sizeToFit()
    }
}
