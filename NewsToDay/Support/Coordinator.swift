//
//  Coordinator.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit

protocol CoordinatorProtocol {
    func getCategoriesModule() -> UIViewController
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
}
