//
//  NetworkManager.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import UIKit

protocol NetworkmanagerProtocol {
    func getNews(for api: String, completed: @escaping (Result<[News], NewsError>) -> Void)
}

class Networkmanager: NetworkmanagerProtocol {
    private var baseURL: String = "https://newsapi.org/v2"
    // cache for image?
    
    let decoder = JSONDecoder()
    private init() {}
    
    
    func getNews(for api: String, completed: @escaping (Result<[News], NewsError>) -> Void) {
        let endPoint = baseURL + "\(NewsService.shared.apiKey)" // здесь будет идти проверка существования API в .plist
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.apiKeyInvalid)) // что-то не так в финальной ссылке с API
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let news = try self.decoder.decode([News].self, from: data)
                completed(.success(news))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
