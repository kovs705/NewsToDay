//
//  DetailPresenter.swift
//  NewsToDay
//
//  Created by Kovs on 15.05.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setNews(news: News?)
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
        self.view?.setNews(news: news ?? News(source: Source(id: "1", name: "Apple"), author: "Apple", title: "Apple Tree", description: "This is an Apple tree with apples", url: "apple.com", urlToImage: "test", publishedAt: "15.05.2023", content: "This is some content of I don't know what to type!"))
    }
    
    
}
