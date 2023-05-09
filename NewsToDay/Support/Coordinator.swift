//
//  Coordinator.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import UIKit

protocol CoordinatorProtocol {
    static func getCategoriesModule() -> UIViewController
}

class Coordinator: CoordinatorProtocol {
    static func getCategoriesModule() -> UIViewController {
        let view = CategoriesViewController()
        let presenter = CategoriesPresenter(view: view, categories: <#[Category]#>)
        view.presenter = presenter
        return view
    }
}