//
//  NetworkManager.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

// Example of searching:
// https://newsapi.org/v2/everything?q=bitcoin&apiKey=8e4cb38d557a45798ecdfa5b7c61f16e


protocol NetworkManagerProtocol {
    func getNews(for api: String, completed: @escaping (Result<[News], NewsError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    private var baseURL: String = "https://newsapi.org/v2"
    // cache for image?
    let decoder = JSONDecoder()
    
    var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIConfig", ofType: "plist") else {
                fatalError("Couldn't find file 'APIConfig.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError(NewsError.apiKeyMissing.rawValue)
            }
            return value
        }
    }
    
    func getNews(for api: String, completed: @escaping (Result<[News], NewsError>) -> Void) {
        let components = "\(baseURL)/top-headlines?country=us&apiKey=\(apiKey)"
        
        guard let url = URL(string: components) else {
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
