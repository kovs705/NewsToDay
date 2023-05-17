//
//  NewsNetworkManager.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 16.05.2023.
//

import Foundation

protocol NewsNetworkManagerProtocol {
    
}

class NewsNetworkManager {
    let decoder = JSONDecoder()
    private var apiKey: String {
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
    
//    func getHeadline<T: Decodable>(queryItems: [URLQueryItem], endpoint: Endpoint, responseModel: T.Type) async throws -> Result<T, NewsError> {
//        guard let url = getUrl(endpoint: endpoint, queryItems: queryItems) else { return .failure(.invalidURL) }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            return .failure(.invalidResponse)
//        }
//
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let result = try decoder.decode(BaseResponse<NewsResponse>.self, from: data)
//
//        return result.articles.map { article in
//            article.toNews()
//        }
//    }
    
    private func getUrl(endpoint: Endpoint, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/" + endpoint.rawValue
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
