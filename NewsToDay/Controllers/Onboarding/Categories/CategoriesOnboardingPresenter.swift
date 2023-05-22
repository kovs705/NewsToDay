//
//  CategoriesOnboardingPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 15.05.2023.
//

import Foundation

protocol CategoriesOnboardingViewProtocol: AnyObject {
    func disableButton(isEnabled: Bool)
}

protocol CategoriesOnboardingPresenterProtocol: AnyObject {
    init(view: CategoriesOnboardingViewProtocol, categories: CategoryManagerProtocol?)
    var categories: CategoryManagerProtocol? { get }
    func select(_ category: Category)
    func deselect(_ category: Category)
    
    func getStarted()
}

class CategoriesOnboardingPresenter: CategoriesOnboardingPresenterProtocol {
    weak var view: CategoriesOnboardingViewProtocol?
    var categories: CategoryManagerProtocol?
    var selectedCategories: [Category] = []
    
    let standard = UserDefaults.standard
    
    required init(view: CategoriesOnboardingViewProtocol, categories: CategoryManagerProtocol?) {
        self.view = view
        self.categories = categories
    }
    
    func select(_ category: Category) {
        selectedCategories.append(category)
        updateButton()
    }
    
    func deselect(_ category: Category) {
        if let index = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: index)
        }
        updateButton()
    }
    
    func getStarted() {
        // standard.set(categories, forKey: Keys.categories)
        print("You chose \(selectedCategories)")
    }
    
    //MARK: - Private Methods

    private func updateButton() {
        if selectedCategories.isEmpty {
            view?.disableButton(isEnabled: false)
        } else {
            view?.disableButton(isEnabled: true)
        }
    }
}
