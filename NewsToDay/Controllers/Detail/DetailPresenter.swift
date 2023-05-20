//
//  DetailPresenter.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setNews(news: News?)
    func isBookmarked(isB: Bool)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, news: News?)
    func setNews()
}


class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var news: News?
    
    required init(view: DetailViewProtocol, news: News?) {
        self.view = view
        self.news = news
    }
    
    public func setNews() {
        
        PersistenceManager.shared.retreiveNews { result in
            switch result {
            case .success(let news):
                guard news.contains((self.news)!) else {
                    self.view?.isBookmarked(isB: false)
                    return
                }
                
                self.view?.isBookmarked(isB: true)
            case .failure(let error):
                print(error)
            }
        }
        
        self.view?.setNews(news: news ?? News(source: Source(id: "1", name: "Apple"), author: "Apple", title: "Apple Tree", description: "This is an Apple tree with apples", url: "apple.com", urlToImage: "test", publishedAt: "15.05.2023", content: "This is some content of I don't know what to type!"))
    }
    
    
}
