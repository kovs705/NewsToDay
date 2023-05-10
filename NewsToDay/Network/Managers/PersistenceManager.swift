//
//  PersistenceManager.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

protocol PersistenceManagerProtocol {
    static func updateWith(bookmark: News, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void)
    static func retreiveNews(completed: @escaping (Result<[News], NewsError>) -> Void)
    static func save(bookmarks: [News]) -> NewsError?
}

enum PersistenceActionType { case add, remove }

class PersistenceManager: PersistenceManagerProtocol {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let bookmarks = "bookmarks"
    }
    
    private init() {}
    
    static func updateWith(bookmark: News, actionType: PersistenceActionType, completed: @escaping (NewsError?) -> Void) {
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
                
                completed(save(bookmarks: bookmarks))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retreiveNews(completed: @escaping (Result<[News], NewsError>) -> Void) {
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
    
    static func save(bookmarks: [News]) -> NewsError? {
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


