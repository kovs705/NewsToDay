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
    init(view: CategriesViewProtocol, categories: [Category])
}
// Possible options: business entertainment general health science sports technology
class CategoriesPresenter: CategoriesPresenterProtocol {
    weak var view: CategriesViewProtocol?
    var categories: [Category]
    
    required init(view: CategriesViewProtocol, categories: [Category]) {
        self.view = view
        self.categories = categories
    }
}
