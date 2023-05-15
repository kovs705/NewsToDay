//
//  CategoriesOnboardingPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 15.05.2023.
//

import Foundation

protocol CategoriesOnboardingViewProtocol: AnyObject {
    
}

protocol CategoriesOnboardingPresenterProtocol: AnyObject {
    init(view: CategoriesOnboardingViewProtocol, categories: CategoryManagerProtocol?)
    var categories: CategoryManagerProtocol? { get }
}

class CategoriesOnboardingPresenter: CategoriesOnboardingPresenterProtocol {
    weak var view: CategoriesOnboardingViewProtocol?
    var categories: CategoryManagerProtocol?
    
    required init(view: CategoriesOnboardingViewProtocol, categories: CategoryManagerProtocol?) {
        self.view = view
        self.categories = categories
    }
    
    
}
