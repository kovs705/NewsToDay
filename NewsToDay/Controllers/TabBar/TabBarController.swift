//
//  TabBarController.swift
//  NewsToDay
//
//  Created by Kovs on 06.05.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        setupTabs()
    }
    private func setupTabs() {
        let categories = Coordinator.getCategoriesModule()
        
        let navigationController = UINavigationController(rootViewController: categories)
        
        navigationController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "square.grid.2x2"),
            tag: 1
        )
        
        let tabs = [navigationController] // VCs here
        tabs.forEach { tab in
            tab.navigationItem.largeTitleDisplayMode = .automatic
            tab.navigationBar.prefersLargeTitles = true
        }
        setViewControllers(tabs, animated: true)
    }
    
    
    
}
