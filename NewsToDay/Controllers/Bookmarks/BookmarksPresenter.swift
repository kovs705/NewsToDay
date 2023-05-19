//
//  BookmarksPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 19.05.2023.
//

import Foundation

protocol BookmarksViewProtocol: AnyObject {
    func success()
    func failure()
}

protocol BookmarksPresenterProtocol: AnyObject {
    var news: [News]? { get set }
    init(view: BookmarksViewProtocol, persistenceManager: PersistenceManagerProtocol)
    func getBookmarks()
}

final class BookmarksPresenter: BookmarksPresenterProtocol {
    weak var view: BookmarksViewProtocol?
    var news: [News]?
    let persistenceManager: PersistenceManagerProtocol!
    
    required init(view: BookmarksViewProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.view = view
        self.persistenceManager = persistenceManager
    }
    
    func getBookmarks() {
        persistenceManager.retreiveNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                self?.view?.success()
            case .failure(_):
                self?.view?.failure()
            }
        }
    }
    
//    func fetchHeadlines() {
//        let request = TopHeadlinesRequest(category: category, page: page)
//        page += 1
//        networkService.request(request) { [weak self] result in
//            switch result {
//            case .success(let news):
//                guard let news else { return }
//                self?.news.append(contentsOf: news)
//                self?.view?.success()
//                self?.isFetchig = false
//            case .failure(let error):
//                self?.view?.failure(error: error)
//                self?.isFetchig = false
//            }
//        }
//    }
}
