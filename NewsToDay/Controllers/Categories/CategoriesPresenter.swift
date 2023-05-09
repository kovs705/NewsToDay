//
//  CategoriesPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 08.05.2023.
//

import Foundation

protocol CategriesViewProtocol: AnyObject {
    
}


protocol CategoriesPresenterProtocol: AnyObject {
    var categories: CategoryManagerProtocol? { get }
    init(view: CategriesViewProtocol, categories: CategoryManagerProtocol?)
}

final class CategoriesPresenter: CategoriesPresenterProtocol {
    weak var view: CategriesViewProtocol?
    var categories: CategoryManagerProtocol?
    
    required init(view: CategriesViewProtocol, categories: CategoryManagerProtocol?) {
        self.view = view
        self.categories = categories
    }
}
