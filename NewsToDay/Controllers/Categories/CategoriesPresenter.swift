//
//  CategoriesPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import Foundation

protocol CategoriesViewProtocol: AnyObject {
    
}

protocol CategoriesPresenterProtocol: AnyObject {
    var categories: CategoryManagerProtocol? { get }
    init(view: CategoriesViewProtocol, categories: CategoryManagerProtocol?)
}

final class CategoriesPresenter: CategoriesPresenterProtocol {
    weak var view: CategoriesViewProtocol?
    var categories: CategoryManagerProtocol?
    
    required init(view: CategoriesViewProtocol, categories: CategoryManagerProtocol?) {
        self.view = view
        self.categories = categories
    }
}
