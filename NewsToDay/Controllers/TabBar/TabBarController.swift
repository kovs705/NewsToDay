//
//  TabBarController.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Property
    
    var coordinator: BuilderProtocol?
    
    //MARK: - Init
    
    init(coordinator: BuilderProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupTabs()
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupTabs() {
        let categories = coordinator?.getCategoriesModule()
        let browse = coordinator?.getBrowseModule()
        let profile = coordinator?.getProfileModule()
        let bookmarks = coordinator?.getBookmarksModule()
        
        var tabs: [UINavigationController] = []
        
        if let browseNavigationController = setupViewController(browse,
                                                                title: NSLocalizedString("HOME_TITLE_LABEL", comment: "Browse"),
                                                                iconSystemName: "house") {
            tabs.append(browseNavigationController)
        }
        if let categoriesNavigationController = setupViewController(categories,
                                                                    title: NSLocalizedString("CATEGORIES_HEADER_TITLE", comment: "Categories"),
                                                                    iconSystemName: "square.grid.2x2") {
            tabs.append(categoriesNavigationController)
        }
        
        if let bookmarksNavigationController = setupViewController(bookmarks,
                                                                   title: NSLocalizedString("BOOKMARKS_TITLE_LABEL", comment: "Bookmarks"),
                                                                   iconSystemName: "bookmark") {
            tabs.append(bookmarksNavigationController)
        }
        
        if let profileViewController = setupViewController(profile,
                                            title: NSLocalizedString("PROFILE_PROFILE_LABEL", comment: "Profile"),
                                            iconSystemName: "person") {
            tabs.append(profileViewController)
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    private func setupViewController(_ viewController: UIViewController?,
                                     title: String, iconSystemName: String) -> UINavigationController? {
        guard let viewController else { return nil }
        viewController.title = title
        viewController.tabBarItem.image = UIImage(systemName: iconSystemName)?.withBaselineOffset(fromBottom: 16)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = UIColor(named: Colors.purplePrimary.rawValue)
        return navigationController
    }
    
    private func setupTabBar() {
        tabBar.layer.cornerRadius = 12
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true

        
        tabBar.tintColor = UIColor(named: Colors.purplePrimary.rawValue)
        tabBar.unselectedItemTintColor = UIColor(named: Colors.greyLight.rawValue)
        removeTabbarItemsText()
    }
    
    private func removeTabbarItemsText() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.title = ""
        }
    }
}
