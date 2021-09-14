//
//  BooksViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 31-08-21.
//  
//

import UIKit

// MARK: - BooksViewController
final class BooksViewController: UIViewController {
    @IBOutlet weak var booksCollectionView: UICollectionView!
    var presenter: BooksPresenterProtocol?
    var dataSource = [BookItemCellDataSource]()
}

// MARK: - Lifecycle
extension BooksViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onViewWillAppear()
    }
}

// MARK: - BooksViewProtocol
extension BooksViewController: BooksViewProtocol {
    func set(dataSource: [BookItemCellDataSource]) {
        self.dataSource.removeAll()
        self.dataSource.append(contentsOf: dataSource)
        
        booksCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension BooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookItemCell.reuseIdentifier, for: indexPath)
        
        guard let bookItemCell = cell as? BookItemCell else { return cell }
        
        let dataSource = dataSource[indexPath.item]
        
        bookItemCell.dataSource = dataSource
        bookItemCell.delegate = self
        
        return bookItemCell
    }
}

// MARK: - UICollectionViewDelegate
extension BooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedItem = dataSource[indexPath.item]
        
        presenter?.didSelectItem(item: selectedItem)
    }
}

// MARK: - UICollectionViewFlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 2.3
        let height = UIScreen.main.bounds.height / 2.4
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - BookItemCellDelegate
extension BooksViewController: BookItemCellDelegate {
    func reloadData() {
        booksCollectionView.reloadData()
    }
}
