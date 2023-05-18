//
//  TabBarController.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Property
    
    var coordinator: CoordinatorProtocol?
    
    //MARK: - Init
    
    init(coordinator: CoordinatorProtocol) {
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
        let browse = BrowseViewController()
        let profile = coordinator?.getProfileModule()
        
        let account = coordinator?.getAccountVCModule()
        let register = coordinator?.getRegisterVCModule()
        
        var tabs: [UINavigationController] = []
        
        if let browseNavigationController = setupViewController(browse,
                                                                title: "Browse",
                                                                iconSystemName: "house") {
            tabs.append(browseNavigationController)
        }
        if let categoriesNavigationController = setupViewController(categories,
                                                                    title: "Categories",
                                                                    iconSystemName: "square.grid.2x2") {
            tabs.append(categoriesNavigationController)
        }
        
        if let blabla = setupViewController(profile, title: "Profile", iconSystemName: "house") {
            tabs.append(blabla)
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
        return navigationController
    }
    
    private func setupTabBar() {
        tabBar.layer.cornerRadius = 12
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true

        
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
