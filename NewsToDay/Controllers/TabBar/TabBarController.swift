//
//  TabBarController.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBar()
    }
    
    private func setupTabs() {
        let categories = Coordinator.getCategoriesModule()
        let browse = BrowseViewController()
        
        let browseNavigationController = setupViewController(browse,
                                                             title: "Browse",
                                                             iconSystemName: "house")
        let categoriesNavigationController = setupViewController(categories,
                                                                 title: "Categories",
                                                                 iconSystemName: "square.grid.2x2")
        let tabs = [browseNavigationController, categoriesNavigationController] // VCs here
        setViewControllers(tabs, animated: true)
    }
    
    private func setupViewController(_ viewController: UIViewController,
                                     title: String, iconSystemName: String) -> UINavigationController {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(systemName: iconSystemName)?.withBaselineOffset(fromBottom: 16)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func setupTabBar() {
        tabBar.layer.borderColor = UIColor(named: Colors.greyLighter)?.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.cornerRadius = 12
        tabBar.tintColor = UIColor(named: Colors.purplePrimary)
        tabBar.unselectedItemTintColor = UIColor(named: Colors.greyLight)
        removeTabbarItemsText()
    }
    
    private func removeTabbarItemsText() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.title = ""
        }
    }
}
