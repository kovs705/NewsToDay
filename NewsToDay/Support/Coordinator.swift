//
//  Coordinator.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit

protocol CoordinatorProtocol {
    func getCategoriesModule() -> UIViewController
    static func getResultModule(category: Category) -> UIViewController
    func getCategoriesOnboardingModule() -> UIViewController
    func getProfileModule() -> UIViewController
    func getDetailVCModule(news: News) -> UIViewController
    
    func getAccountVCModule() -> UIViewController
    func getRegisterVCModule() -> UIViewController
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
    
    static func getResultModule(category: Category) -> UIViewController {
        let view = ResultViewController()
        let networkService = DefaultNetworkService()
        let presenter = ResultPresenter(view: view, networkService: networkService, category: category)
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
    
    func getProfileModule() -> UIViewController {
        let view = ProfileVC()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func getDetailVCModule(news: News) -> UIViewController {
        let view = DetailVC()
        let presenter = DetailPresenter(view: view,
                                        news: news)
        view.presenter = presenter
        return view
    }
    
    func getAccountVCModule() -> UIViewController {
        let view = AccountController()
        let presenter = AccountPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    func getRegisterVCModule() -> UIViewController {
        let view = RegisterController()
        let presenter = RegisterPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
