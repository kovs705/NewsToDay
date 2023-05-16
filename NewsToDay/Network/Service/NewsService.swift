//
//  NewsService.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation


final class NewsService {
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
    
    func getHeadline() async throws -> [News] {
//        let components = URLComponents(string: "\(baseURL)/top-headlines?country=us&apiKey=\(apiKey)")!
        let components = URLComponents()
        components
        
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetch the data.")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(BaseResponse<HeadlineResponse>.self, from: data)
        
        return result.articles.map { article in
            article.toNews()
        }
    }
}
