//
//  NewsNetworkService.swift
//  NewsToDay
//
//  Created by Mikhail Tedeev on 16.05.2023.
//

import Foundation

protocol NewsNetworkServiceProtocol {
    init(networkClient: NewsNetworkClientProtocol)
    func getHeadlines() async -> Result<NewsModel, NewsError>
//    func getResult(forPage page: Int, byCategory: Category) async -> Result<News, NewsError>
}

final class NewsNetworkService: NewsNetworkServiceProtocol {
    var networkClient: NewsNetworkClientProtocol!
    
    required init(networkClient: NewsNetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func getHeadlines() async -> Result<NewsModel, NewsError> {
        return await networkClient.sendRequest(endpoint: .topHeadlines,
                                               responseModel: NewsModel.self,
                                               queryItems: [
                                                URLQueryItem(name: "country", value: "ru"),
                                               ])
    }
    
//    func getResult(forPage page: Int, byCategory: Category) async -> Result<News, NewsError> {
//
//    }
}
