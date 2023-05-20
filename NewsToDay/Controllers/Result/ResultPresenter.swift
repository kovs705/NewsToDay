//
//  ResultPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 12.05.2023.
//

import Foundation

protocol ResultViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol ResultPresenterProtocol: AnyObject {
    var news: [News] { get set }
    var isFetchig: Bool { get set }
    init(view: ResultViewProtocol, networkService: NetworkService, category: Category)
    func fetchHeadlines()
}

final class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewProtocol?
    var networkService: NetworkService!
    var category: Category!
    var page = 1
    var isFetchig = false
    var news = [News]()
    
    required init(view: ResultViewProtocol, networkService: NetworkService, category: Category) {
        self.view = view
        self.networkService = networkService
        self.category = category
    }
    
    func fetchHeadlines() {
        let request = TopHeadlinesRequest(category: category, page: page)
        page += 1
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let news):
                guard let news else { return }
                self?.news.append(contentsOf: news)
                self?.view?.success()
                self?.isFetchig = false
            case .failure(let error):
                self?.view?.failure(error: error)
                self?.isFetchig = false
            }
        }
    }
}
