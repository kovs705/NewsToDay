//
//  NewsNetworkClient.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 16.05.2023.
//

import Foundation
import UIKit

protocol NewsNetworkClientProtocol {
    func sendRequest<T: Decodable>(endpoint: Web.Endpoint, responseModel: T.Type, queryItems: [URLQueryItem]) async -> Result<T, NewsError>
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
}

final class NewsNetworkClient: NewsNetworkClientProtocol {
    let decoder = JSONDecoder()
    
    static let shared = NewsNetworkClient()
    let cache = NSCache<NSString, UIImage>() // NSString as a key, UIImage as a value
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "APIobj", ofType: "plist") else {
                fatalError("Couldn't find file 'APIConfig.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError(NewsError.apiKeyMissing.rawValue)
            }
            return value
        }
    }
    
    func sendRequest<T: Decodable>(endpoint: Web.Endpoint, responseModel: T.Type, queryItems: [URLQueryItem]) async -> Result<T, NewsError> {
        guard let url = getUrl(endpoint: endpoint, queryItems: queryItems) else { return .failure(.invalidURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decoded = try? decoder.decode(responseModel.self, from: data) else {
                    return .failure(.invalidData)
                }
                return .success(decoded)
            case 401: return .failure(.unauthorized)
            default: return.failure(.unexpectedError)
            }
        } catch {
            return.failure(.unexpectedError)
        }
    }
    
    private func getUrl(endpoint: Web.Endpoint, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        var defaultQueryItems = [URLQueryItem(name: "apiKey", value: apiKey)]
        defaultQueryItems.append(contentsOf: queryItems)
        
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/" + endpoint.rawValue
        urlComponents.queryItems = defaultQueryItems
        
        return urlComponents.url
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
