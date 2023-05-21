//
//  NewBrowsePresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 21.05.2023.
//

import Foundation

protocol NewBrowseViewProtocol {
    
}

protocol NewBrowsePresenterProtocol {
    
}

class NewBrowsePresenter: NewBrowsePresenterProtocol {weak var view: ResultViewProtocol?
    var networkService: NetworkService!
    var category = CategoryManager().all[0]
    var headNews = [News]()
    
    required init(view: ResultViewProtocol, networkService: NetworkService, category: Category) {
        self.view = view
        self.networkService = networkService
        self.category = category
        fetchHead()
    }
    
    func fetchHead() {
        let request = BrowseHeadlinesRequest(category: category)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let news):
                guard let news else { return }
                self?.headNews = news
                self?.view?.success()
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
    
    func fetchRec() {
        
    }
}
