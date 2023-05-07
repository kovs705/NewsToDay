//
//  NewsService.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation


class NewsService {
    
    private var baseURL: String = "https://newsapi.org/v2"
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
    
    static let shared = NewsService()
    
    func getHeadline() async throws -> [News] {
        let components = URLComponents(string: "\(baseURL)/top-headlines?country=id&apiKey=\(apiKey)")!
        
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetch the data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(BaseResponse<NewsResponse>.self, from: data)
        
        return result.articles.map { article in
            article.toNews()
        }
    }
    
    
}
