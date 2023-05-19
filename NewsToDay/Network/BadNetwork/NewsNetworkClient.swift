//
//  NewsNetworkClient.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 16.05.2023.
//

import Foundation

protocol NewsNetworkClientProtocol {
    func sendRequest<T: Decodable>(endpoint: Web.Endpoint,
                                   responseModel: T.Type,
                                   queryItems: [URLQueryItem]) async -> Result<T, NewsError>
    func loadImageData(urlString: String) async -> Result<Data, NewsError>
}

final class NewsNetworkClient: NewsNetworkClientProtocol {
    let decoder = JSONDecoder()
    var cachedData = NSCache<NSString, NSData>()
    
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
            default:
                print(response)
                return.failure(.unexpectedError)
            }
        } catch {
            return.failure(.unexpectedError)
        }
    }
    
    func loadImageData(urlString: String) async -> Result<Data, NewsError> {
        if let cachedImage = cachedData.object(forKey: urlString as NSString) {
            return .success(cachedImage as Data)
        } else {
            guard let url = URL(string: urlString) else { return .failure(.invalidURL) }
            let request = URLRequest(url: url)
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let response = response as? HTTPURLResponse else {
                    return .failure(.invalidResponse)
                }
                switch response.statusCode {
                case 200...299:
                    return .success(data)
                case 401: return .failure(.unauthorized)
                default: return.failure(.unexpectedError)
                }
            } catch {
                return .failure(.unexpectedError)
            }
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
}
