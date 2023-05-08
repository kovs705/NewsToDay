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
    init(view: CategriesViewProtocol)
}
// Possible options: business entertainment general health science sports technology
class CategoriesPresenter: CategoriesPresenterProtocol {
    weak var view: CategriesViewProtocol?
    
    required init(view: CategriesViewProtocol) {
        self.view = view
    }
}
