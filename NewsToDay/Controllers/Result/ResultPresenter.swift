//
//  ResultPresenter.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 12.05.2023.
//

import Foundation

protocol ResultViewProtocol: AnyObject {
    func success()
    func failure()
}

protocol ResultPresenterProtocol: AnyObject {
    var news: [News] { get }
    init(view: ResultViewProtocol, networkService: NewsNetworkServiceProtocol, category: Category)
    func fetch(forCategory category: Category, complition: @escaping (Result<NewsModel, NewsError>) -> Void)
    func fetch(imageFor urlString: String, complition: @escaping (Result<Data, NewsError>) -> Void)
}

final class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewProtocol?
    var networkService: NewsNetworkServiceProtocol!
    var category: Category!
    var page = 1
    var news = [News]()
    
    required init(view: ResultViewProtocol, networkService: NewsNetworkServiceProtocol, category: Category) {
        self.view = view
        self.networkService = networkService
        self.category = category
        loadNextPage()
    }
    
    func loadNextPage() {
        fetch(forCategory: category) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                guard let bindedNews = success.articles else {return}
                self.news.append(contentsOf: bindedNews)
                self.view?.success()
            case .failure(let failure):
                print(failure.localizedDescription)
                break
            }
        }
    }
    
    func fetch(forCategory category: Category, complition: @escaping (Result<NewsModel, NewsError>) -> Void) {
        Task(priority: .background) {
            let result = await networkService.getResult(byCategory: category, forPage: self.page)
            self.page += 1
            complition(result)
        }
    }
    
    func fetch(imageFor urlString: String, complition: @escaping (Result<Data, NewsError>) -> Void) {
        Task(priority: .background) {
            let result = await networkService.loadImage(urlString: urlString)
            complition(result)
        }
    }
}
