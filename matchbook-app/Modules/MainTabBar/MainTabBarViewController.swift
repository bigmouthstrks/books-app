//
//  MainTabBarViewController.swift
//  matchbook-app
//
//  Created by Benjamin Cáceres on 27-08-21.
//  
//

import UIKit

// MARK: - Tabs
enum Tabs: Int, CaseIterable {
    case books = 0
    case profile
    
    var icon: UIImage? {
        switch self {
        case .books: return UIImage(systemName: "book.fill")
        case .profile: return UIImage(systemName: "person.fill")
        }
    }
    
    var title: String {
        switch self {
        case .books: return "Libros"
        case .profile: return "Perfil"
        }
    }
}

// MARK: - MainTabBarViewController
final class MainTabBarViewController: UITabBarController {
    var presenter: MainTabBarPresenterProtocol?
    var isStillAnimatingTransition = false
    
    lazy var bottomNavBar: UITabBar = {
        let bottomNavBar = UITabBar()
        let bottomNavBarFont = UIFont.systemFont(ofSize: 12)
        
        let booksTabBarItem = UITabBarItem(title: Tabs.books.title, image: Tabs.books.icon, tag: 0)
        let profileTabBarItem = UITabBarItem(title: Tabs.profile.title, image: Tabs.profile.icon, tag: 1)
        
        bottomNavBar.barTintColor = .primaryDark
        bottomNavBar.delegate = self
        bottomNavBar.items = [booksTabBarItem, profileTabBarItem]
        bottomNavBar.unselectedItemTintColor = .coldNeutral2
        bottomNavBar.tintColor = .primaryLight
        
        return bottomNavBar
    }()
}

// MARK: - Lifecycle
extension MainTabBarViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayoutSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onViewWillAppear()
    }
}

// MARK: - MainTabBarViewController {
extension MainTabBarViewController {
    func setupLayoutSubViews() {
        let size = bottomNavBar.sizeThatFits(view.bounds.size)
        var bottomNavBarFrame = CGRect(x: 0, y: view.bounds.height - size.height + 30, width: size.width, height: size.height - 30)
        
        bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
        bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
        
        bottomNavBar.frame = bottomNavBarFrame
    }
}

// MARK: - UINavigationBarDelegate
extension MainTabBarViewController: UINavigationBarDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard !isStillAnimatingTransition, selectedIndex != item.tag else {
            guard let nc = viewControllers?[selectedIndex] as? UINavigationController else { return }
            nc.popViewController(animated: true)
            
            return
        }
        
        selectedIndex = item.tag
    }
}

// MARK: - MainTabBarViewProtocol
extension MainTabBarViewController: MainTabBarViewProtocol {
    func addBottomNavBarAsSubView() {
        view.addSubview(bottomNavBar)
    }
    
    func setBottomNavBarFrame() {
        let size = bottomNavBar.sizeThatFits(view.bounds.size)
        var bottomNavBarFrame = CGRect(x: 0, y: view.bounds.height - size.height, width: size.width, height: size.height)
        
        bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
        bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
        
        bottomNavBar.frame = bottomNavBarFrame
    }
    
    func select(tab: Tabs) {
        let selectedIndex = tab.rawValue
        
        bottomNavBar.selectedItem = bottomNavBar.items?[selectedIndex]
        
        self.selectedIndex = selectedIndex
    }
}
