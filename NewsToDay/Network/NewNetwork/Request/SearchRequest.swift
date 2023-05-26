//
//  SearchRequest.swift
//  NewsToDay
//
//  Created by Kovs on 26.05.2023.
//

import Foundation

struct SearchResultRequest: DataRequest {
//    private let apiKey: String = Web.APIKey.get.rawValue
    private let apiKey = "7acd60c01e994588bd9ddf3602785ba3"
        
    var searchRequest: String!
    var page = 1
    
    var url: String {
        let baseUrl = "https://newsapi.org/v2"
        let path = "/everything?"
        return baseUrl + path
    }
    
    var queryItems: [String : String] {
        [
            "apiKey": apiKey,
            "page": "\(page)",
            "q": searchRequest
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(searchRequest: String, page: Int) {
        self.searchRequest = searchRequest
        self.page = page
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

