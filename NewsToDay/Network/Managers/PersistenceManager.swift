//
//  PersistenceManager.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

protocol PersistenceManagerProtocol {
    func updateWith(bookmark: News, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void)
    func retreiveNews(completed: @escaping (Result<[News], NewsError>) -> Void)
    func save(bookmarks: [News]) -> NewsError?
}


enum PersistenceActionType { case add, remove }


class PersistenceManager: PersistenceManagerProtocol {
    private let defaults = UserDefaults.standard
    
    static let shared = PersistenceManager()
    
    enum Keys {
        static let bookmarks = "bookmarks"
    }
    
    // MARK: - Добавление или удаление избранного, принимает в функцию новость, выбирается случай, либо add либо remove
    func updateWith(bookmark: News, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void) {
        retreiveNews { result in
            switch result {
            case .success(var bookmarks):
                
                switch actionType {
                case .add:
                    
                    guard !bookmarks.contains(bookmark) else {
                        // if contains:
                        completed(.alreadyBookmarked)
                        return
                    }
                    
                    // if you didn't add this user yet:
                    bookmarks.append(bookmark)
                    
                case .remove:
                    bookmarks.removeAll { $0.url == bookmark.url}
                }
                
                completed(self.save(bookmarks: bookmarks))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
 // MARK: - Получение избранных новостей в виде [News], либо ошибка
    func retreiveNews(completed: @escaping (Result<[News], NewsError>) -> Void) {
        guard let bookmarksData = defaults.object(forKey: Keys.bookmarks) as? Data else {
            // if nil = no favorites
            completed(.success([]))
            return
        }
        
        // decode into bookmarks array:
        do {
            let decoder = JSONDecoder()
            let bookmarks = try decoder.decode([News].self, from: bookmarksData)
            
            completed(.success(bookmarks))
        } catch {
            completed(.failure(.unableToBookmark))
        }
        
    }
    
    func save(bookmarks: [News]) -> NewsError? {
        // encode:
        do {
            let encoder = JSONEncoder()
            let encodedBookmarks = try encoder.encode(bookmarks)
            
            // save to dafaults:
            defaults.set(encodedBookmarks, forKey: Keys.bookmarks)
            return nil
        } catch {
            return .unableToBookmark
        }
    }
}


