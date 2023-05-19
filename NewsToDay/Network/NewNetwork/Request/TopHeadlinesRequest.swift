//
//  TopHeadlinesRequest.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 19.05.2023.
//

import Foundation

struct TopHeadlinesRequest: DataRequest {
    private let apiKey: String = "8e4cb38d557a45798ecdfa5b7c61f16e"
        
    var url: String {
        let baseUrl = "https://newsapi.org/v2"
        let path = "/top-headlines"
        return baseUrl + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "apiKey": apiKey,
            "country": "us"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [News]? {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode(NewsModel.self, from: data)
        return response.articles
    }
    
}