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
    func bookmarkIt()
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
        
        self.view?.setNews(news: self.news ?? News(source: Source(id: "1", name: "Apple"), author: "Apple", title: "Apple Tree", description: "This is an Apple tree with apples", url: "apple.com", urlToImage: "test", publishedAt: "15.05.2023", content: "This is some content of I don't know what to type!"))
    }
    
    func bookmarkIt() {
        PersistenceManager.shared.retreiveNews { result in
            switch result {
            case .success(let news):
                guard news.contains((self.news)!) else {
                    // add
                    PersistenceManager.shared.updateWith(bookmark: self.news!, actionType: .add) { error in
                        guard let error = error else {
                            print("No errors on adding")
                            return
                        }
                        print(error)
                        return
                    }
                    self.view?.isBookmarked(isB: true)
                    return
                }
                
                // delete from bookmarks
                PersistenceManager.shared.updateWith(bookmark: self.news!, actionType: .remove) { error in
                    guard let error = error else {
                        print("No errors on deleting")
                        return
                    }
                    print(error)
                    return
                }
                self.view?.isBookmarked(isB: false)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    
    
}
