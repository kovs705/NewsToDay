//
//  NewBrowsePresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 21.05.2023.
//

import Foundation

enum BrowseItem: Hashable {
    case category([Category])
    case news([News])
}

struct BrowseRow: Hashable {
    var index: Int
    var title: String?
    var items: BrowseItem
}

struct BrowseContent {
    let category: [String]
    let news: [String]
    let article: [String]
}

protocol NewBrowseViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol NewBrowsePresenterProtocol: AnyObject {
    init(view: NewBrowseViewProtocol, networkService: NetworkService)
    var categories: [Category] { get }
//    var browseRow: [BrowseRow] { get }
}

class NewBrowsePresenter: NewBrowsePresenterProtocol {
    weak var view: NewBrowseViewProtocol?
    var networkService: NetworkService!
    var categories = CategoryManager().all
    var recNews = [News]()
    
//    var browseRow = [
//        BrowseRow(index: 0, title: nil, items: [BrowseItem.category(CategoryManager().all)]),
//        BrowseRow(index: 1, title: nil, items: [BrowseItem.news([News]())]),
//    ]
    
    required init(view: NewBrowseViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        fetchHead()
        fetchRec()
    }
    
    func fetchHead() {
        let request = BrowseHeadlinesRequest(category: categories[0])
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let news):
                guard let news else { return }
//                self?.browseRow[1] = BrowseRow(index: 1, title: nil, items: [BrowseItem.news(news)])
                self?.view?.success()
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
    
    func fetchRec() {
        let request = BrowseRecomendationRequest(category: categories[6])
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let news):
                guard let news else { return }
                self?.recNews = news
                self?.view?.success()
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
}
