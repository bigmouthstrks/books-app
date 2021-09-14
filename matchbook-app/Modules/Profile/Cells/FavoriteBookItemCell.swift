//
//  MyBookItemCell.swift
//  Matchbook
//
//  Created by Benjamin Cáceres on 08-09-21.
//
import UIKit

// MARK: - BookItemCellDelegate
protocol MyBookItemCellDelegate: AnyObject {
    func reloadData()
}

// MARK: - BookItemCellDataSource
protocol MyBookItemCellDataSource: DataSource {
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
struct MyBookViewModel: MyBookItemCellDataSource {
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
final class MyBookItemCell: UICollectionViewCell {
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var dataSource: MyBookItemCellDataSource? {
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
    
    static let reuseIdentifier = "myBookItem"
    weak var delegate: MyBookItemCellDelegate!
}

// MARK: - MyBookItemCell
extension MyBookItemCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        authorLabel.text = nil
    }

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
