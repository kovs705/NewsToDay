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
    func getResult(byCategory: Category, forPage page: Int) async -> Result<NewsModel, NewsError>
    func loadImage(urlString: String) async -> Result<Data, NewsError>
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
    
    func loadImage(urlString: String) async -> Result<Data, NewsError> {
        return await networkClient.loadImageData(urlString: urlString)
    }
    
    func getResult(byCategory: Category, forPage page: Int) async -> Result<NewsModel, NewsError> {
        return await networkClient.sendRequest(endpoint: .topHeadlines,
                                               responseModel: NewsModel.self,
                                               queryItems: [
                                                URLQueryItem(name: "country", value: "us"),
                                                URLQueryItem(name: "pageSize", value: "20"),
                                                URLQueryItem(name: "page", value: "\(page)"),
                                               ])
    }
}
