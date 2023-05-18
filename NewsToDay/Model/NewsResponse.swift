//
//  NewsResponse.swift
//  NewsToDay
//
//  Created by Kovs on 07.05.2023.
//

import Foundation

protocol ApiResponse: Decodable {}

struct BaseResponse<T: ApiResponse>: Decodable {
    let status: String
    let totalResults: Int
    let articles: [T]
}

struct SourceResponse: Decodable {
    let id: String?
    let name: String?
}

struct HeadlineResponse: ApiResponse {
    let source: SourceResponse
    let author: String?
    let title, description: String?
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?
}

extension HeadlineResponse {
    func toNews() -> News {
        return News(
            source: Source(id: self.source.id, name: self.source.name ?? ""),
            author: self.author ?? "",
            title: self.title ?? "",
            description: self.description ?? "",
            url: self.url,
            urlToImage: self.urlToImage,
            publishedAt: self.publishedAt,
            content: self.content ?? ""
        )
    }
}
