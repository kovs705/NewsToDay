//
//  Coordinator.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit

protocol CoordinatorProtocol {
    func getCategoriesModule() -> UIViewController
    func getResultModule() -> UIViewController
    func getCategoriesOnboardingModule() -> UIViewController
}

class Coordinator: CoordinatorProtocol {
    func getCategoriesModule() -> UIViewController {
        let view = CategoriesViewController()
        let categories = CategoryManager()
        let presenter = CategoriesPresenter(view: view,
                                            categories: categories)
        view.presenter = presenter
        return view
    }
    
    func getResultModule() -> UIViewController {
        let view = ResultViewController()
        let presenter = ResultPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func getCategoriesOnboardingModule() -> UIViewController {
        let view = CategoriesOnboardingViewController()
        let categories = CategoryManager()
        let presenter = CategoriesOnboardingPresenter(view: view,
                                                      categories: categories)
        view.presenter = presenter
        return view
    }
}
