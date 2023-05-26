//
//  Coordinator.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit

protocol BuilderProtocol {
    func getCategoriesModule() -> UIViewController
    static func getResultModule(category: Category, coordinator: BuilderProtocol) -> UIViewController
    
    func getCategoriesOnboardingModule() -> UIViewController
    func getOnboardingModule() -> UIViewController
    
    func getProfileModule() -> UIViewController
    func getDetailVCModule(news: News) -> UIViewController
    
    
    
    func getAccountVCModule() -> UIViewController
    func getRegisterVCModule() -> UIViewController
    func getBookmarksModule() -> UIViewController
    func getBrowseModule() -> UIViewController
}

final class Builder: BuilderProtocol {
    func getBookmarksModule() -> UIViewController {
        let view = BookmarksViewController()
        let persistenceManager = PersistenceManager()
        let presenter = BookmarksPresenter(view: view, persistenceManager: persistenceManager)
        view.presenter = presenter
        return view
    }
    
    func getCategoriesModule() -> UIViewController {
        let view = CategoriesViewController()
        let categories = CategoryManager()
        let presenter = CategoriesPresenter(view: view,
                                            categories: categories)
        view.presenter = presenter
        return view
    }
    
    static func getResultModule(category: Category, coordinator: BuilderProtocol) -> UIViewController {
        let coordinator = Builder()
        let view = ResultViewController()
        let networkService = DefaultNetworkService()
        let presenter = ResultPresenter(view: view, networkService: networkService, category: category)
        view.presenter = presenter
        view.coordinator = coordinator
        view.title = "\(category.icon) \(category.name.capitalized)"
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
    
    func getOnboardingModule() -> UIViewController {
        let view = OnboardingViewController()
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
        return view
    }
    
    func getRegisterVCModule() -> UIViewController {
        let view = RegisterController()
        return view
    }
    
    
    func getBrowseModule() -> UIViewController {
        let view = BrowseViewController()
        let networkService = DefaultNetworkService()
        let presenter = BrowsePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
